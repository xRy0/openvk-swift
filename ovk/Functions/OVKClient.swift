//
//  OVKClient.swift
//  OpenVK Swift
//
//  Created by Ry0 on 15.06.2025.
//

import Foundation

// Обработчик результатов API: или данные T, или ошибка API.
enum APIResult<T> {
    case success(T)
    case failure(APIError)
}

// Описание ошибки из OpenVK API https://docs.ovk.to/openvk_engine/api/overview/#error.
struct APIError: Decodable, Error {
    let error_code: Int
    let error_msg: String
    let request_params: [RequestParam]?

    struct RequestParam: Decodable {
        let key: String
        let value: String
    }
}

class OVKClient {
    private var baseURL = URL(string: "https://ovk.to/method/")!
    private let session: URLSession

    var accessToken: String?

    init(session: URLSession = .shared) {
        self.session = session
        self.accessToken = getValueFromKeychain(forKey: "token")
        self.baseURL = URL(string: "\(getValueFromUserDefaults(forKey: "instance") ?? "https://ovk.to")/method/")!
    }

    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, APIError>) -> Void) {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)!
        var queryItems = [URLQueryItem]()

        for (key, value) in endpoint.parameters {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        if let token = accessToken {
            queryItems.append(URLQueryItem(name: "access_token", value: token))
        }
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = endpoint.method.rawValue
        
        print(self.baseURL)

        let task = session.dataTask(with: request) { data, response, error in
            // Обработка сетевой ошибки
            if let error = error {
                completion(.failure(APIError(error_code: -1, error_msg: error.localizedDescription, request_params: nil)))
                return
            }
            guard let data = data else {
                completion(.failure(APIError(error_code: -1, error_msg: "No data", request_params: nil)))
                return
            }
            print(String(data: data, encoding: .utf8) ?? "Не удалось декодировать тело ответа в строку")
            let decoder = JSONDecoder()
            // Пробуем декодировать успешный ответ
            do {
                // Попытка декодировать обёртку с полем response
                let wrapper = try decoder.decode(ResponseWrapper<T>.self, from: data)
                if let result = wrapper.response {
                    completion(.success(result))
                } else {
                    // Если нет поля response, пытаемся декодировать сам объект
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                }
            } catch {
                if let decodingError = error as? DecodingError {
                        switch decodingError {
                        case .typeMismatch(let type, let context):
                            print("Type mismatch for type \(type): \(context.debugDescription)")
                            print("CodingPath:", context.codingPath)
                        case .valueNotFound(let type, let context):
                            print("Value not found for type \(type): \(context.debugDescription)")
                            print("CodingPath:", context.codingPath)
                        case .keyNotFound(let key, let context):
                            print("Key '\(key)' not found: \(context.debugDescription)")
                            print("CodingPath:", context.codingPath)
                        case .dataCorrupted(let context):
                            print("Data corrupted: \(context.debugDescription)")
                            print("CodingPath:", context.codingPath)
                        @unknown default:
                            print("Unknown decoding error: \(decodingError)")
                        }
                    } else {
                        print("Other error: \(error.localizedDescription)")
                    }
                
                // При ошибке парсинга пробуем декодировать структуру ошибки API
                if let apiErr = try? decoder.decode(APIError.self, from: data) {
                    completion(.failure(apiErr))
                } else {
                    // Если не получилось, возвращаем общую ошибку
                    let unknown = APIError(error_code: -1, error_msg: "Decoding error", request_params: nil)
                    completion(.failure(unknown))
                }
            }
        }
        task.resume()
    }
}

private struct ResponseWrapper<T: Decodable>: Decodable {
    let response: T?
}

// Метод HTTP (GET или POST)
enum HTTPMethod: String {
    case GET, POST
}

// Перечисляем поддерживаемые эндпоинты API
enum Endpoint {
    case accountGetProfileInfo
    case accountSetOnline
    
    case newsfeedAddBan(userIds: [Int]?, groupIds: [Int]?)
    case usersGetMe(fields: [String]?)
    
    case wallGet(ownerId: Int?, extended: Int?, count: Int?)
    
    // Распознавание пути, HTTP-метода и параметров
    var path: String {
        switch self {
        case .accountGetProfileInfo:
            return "account.getProfileInfo"
        case .accountSetOnline:
            return "account.setOnline"
        case .newsfeedAddBan:
            return "newsfeed.addBan"
        case .usersGetMe:
            return "users.get"
        case .wallGet:
            return "wall.get"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .accountGetProfileInfo:
            return .GET
        case .accountSetOnline:
            return .GET
        case .newsfeedAddBan:
            return .POST
        case .usersGetMe:
            return .GET
        case .wallGet:
            return .GET
        }
    }
    var parameters: [String: Any] {
        switch self {
        case .accountGetProfileInfo:
            return [:]  // этот метод не требует дополнительных параметров
        case .accountSetOnline:
            return [:]
        case .newsfeedAddBan(let userIds, let groupIds):
            var params: [String: Any] = [:]
            if let users = userIds {
                params["user_ids"] = users.map { String($0) }.joined(separator: ",")
            }
            if let groups = groupIds {
                params["group_ids"] = groups.map { String($0) }.joined(separator: ",")
            }
            return params
        case .usersGetMe(let fields):
            var params: [String: Any] = [:]
            if let fields = fields {
                params["fields"] = fields.map { String($0) }.joined(separator: ",")
            }
            return params
        case .wallGet(let ownerId, let extended, let count):
            return ["owner_id": ownerId ?? 0, "extended": extended ?? 1, "count": count ?? 5]
        }
    }
}
