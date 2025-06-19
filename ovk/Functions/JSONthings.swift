//
//  JSONtoDict.swift
//  ovk
//
//  Created by Isami Riša on 24.10.2023.
//

import Foundation

func JSONtoDict(from jsonString: String) throws -> [String: Any]? {
    if let jsonData = jsonString.data(using: .utf8) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let jsonDict = jsonObject as? [String: Any] {
                return jsonDict
            }
        } catch {
            throw JSONtoDictError(error.localizedDescription)
        }
    }
    return nil
}

func DictToString(from dictionary: [String: Any]) -> String? {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonString = String(data: jsonData, encoding: .utf8)
        return jsonString
    } catch {
        return error.localizedDescription
    }
}

func toBool(from value: Any) -> Bool {
    switch value {
    case let b as Bool:
        return b
    case let i as Int:
        return i != 0
    case let s as String:
        return ["true", "1"].contains(s.lowercased())
    default:
        return false
    }
}
