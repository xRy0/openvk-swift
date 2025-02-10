//
//  LoginService.swift
//  OpenVK Swift
//
//  Created by Ry0 on 28.01.2025.
//

import Foundation

class LoginService {
    static let shared = LoginService()
    
    func login(instance: String, username: String, password: String, completion: @escaping ([String: Any]?) -> Void) {
        LogIn(login: username, password: password, instance: instance, completion: completion)
    }
}
