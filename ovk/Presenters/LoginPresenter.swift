//
//  LoginPresenter.swift
//  OpenVK Swift
//
//  Created by Ry0 on 05.06.2025.
//
import Combine
import SwiftUI

class LoginPresenter: ObservableObject {
    @Published var login = ""
    @Published var password = ""
    @Published var code = ""
    @Published var instance: String
    @Published var addedInstances: [String] = []
    @Published var mainInstances: [String] = ["https://ovk.to", "https://vepurovk.xyz"]
    @Published var instanceToDelete: String? = nil
    @Published var showDeleteAlert = false
    @Published var showEditSheet = false
    @Published var showAddAlert = false
    @Published var newInstanceText = ""
    
    @Published var shouldNavigateToMainView = false
    @Published var error = ""
    @Published var alertText = ""
    @Published var showAlert = false
    @Published var isLoading = false
    @Published var isWebViewOpened = false
    @Published var webViewURL = URL("https://ovk.to/reg")
    @Published var show2FA = false
    
    @Published var debugToken = ""
    
    init (instance: String) {
        self.instance = instance
        self.addedInstances = getArrayFromUserDefaults(forKey: "instances") ?? []
    }
    
    public func handleCustomTokenLogin(){
        guard !instance.isEmpty || !debugToken.isEmpty else {
            return
        }
        
        guard saveValueToKeychain(forKey: "token", value: debugToken) else {
            return
        }
        shouldNavigateToMainView.toggle()
        saveValueToUserDefaults(forKey: "instance", value: instance)
    }
    
    func completion(response: [String: Any]?) {
        isLoading = false
        guard let response = response else {
            error = "Нет ответа от сервера"
            return
        }

        if let errorMsg = response["error_msg"] as? String {
            if errorMsg == "Invalid 2FA code", !show2FA {
                show2FA = true
            } else {
                error = errorMsg
            }
            return
        }

        guard let token = response["access_token"] as? String else {
            error = "Нет токена в ответе"
            return
        }

        if saveValueToKeychain(forKey: "token", value: token) {
            saveValueToUserDefaults(forKey: "instance", value: instance)
            shouldNavigateToMainView.toggle()
        } else {
            error = "Токен не может быть сохранён, так как имеется другой"
        }
    }
    
    public func handleLogin(){
        isLoading = true
        AuthenticationManager.shared.login(instance: instance, username: login, password: password, code: code, completion: completion)
    }
    
    public func openUrl(path: String){
        webViewURL = URL(string: "\(instance)/\(path)")!
        isWebViewOpened = true
    }
    
    func addInstance() {
            let trimmed = newInstanceText.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty, !addedInstances.contains(trimmed) else { return }
            addedInstances.append(trimmed)
            newInstanceText = ""
            saveArrayToUserDefaults(forKey: "instances", value: addedInstances)
        }
    
    func deleteInstances(at offsets: IndexSet) {
            addedInstances.remove(atOffsets: offsets)
            saveArrayToUserDefaults(forKey: "instances", value: addedInstances)
        }
    
}

extension LoginPresenter {
    static var mock: LoginPresenter {
        let presenter = LoginPresenter(instance: "https://ovk.to")
        presenter.login = "demo_user"
        presenter.password = "123456"
        presenter.code = ""
        presenter.addedInstances = ["https://mock.instance", "https://demo.site"]
        presenter.newInstanceText = "https://new.instance"
        presenter.showAddAlert = false
        presenter.showDeleteAlert = false
        presenter.showEditSheet = false
        presenter.error = ""
        presenter.alertText = ""
        presenter.showAlert = false
        presenter.isLoading = false
        presenter.isWebViewOpened = false
        presenter.webViewURL = URL(string: "https://ovk.to/reg")!
        presenter.show2FA = false
        presenter.debugToken = ""
        return presenter
    }
}
