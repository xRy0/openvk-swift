//
//  AuthenticationManager.swift
//  OpenVK Swift
//
//  Created by Ry0 on 28.01.2025.
//

import Foundation

class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    func isUserLoggedIn() -> Bool {
        return getValueFromKeychain(forKey: "token") != nil
    }
}
