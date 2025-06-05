//
//  LoginPresenter.swift
//  OpenVK Swift
//
//  Created by Ry0 on 05.06.2025.
//
import Combine

class LoginPresenter: ObservableObject {
    @Published var login = ""
    @Published var password = ""
    @Published var code = ""
    @Published var instance: String
    
    @Published var debugToken = ""
    
    init (instance: String) {
        self.instance = instance
    }
    
    public func handleCustomTokenLogin(){
        guard !instance.isEmpty || !debugToken.isEmpty else {
            print("pizdec")
            return
        }
        
        guard saveValueToKeychain(forKey: "token", value: debugToken) else {
            print("zrada")
            return
        }
        
        saveValueToUserDefaults(forKey: "instance", value: instance)
    }
    
    /*public func setToken(token: String) {
        self.token = token
    }*/
}
