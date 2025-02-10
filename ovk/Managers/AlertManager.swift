//
//  AlertManager.swift
//  OpenVK Swift
//
//  Created by Ry0 on 28.01.2025.
//

import SwiftUI

class AlertManager {
    static let shared = AlertManager()
    
    func showAlert(message: String) -> Alert {
        return Alert(title: Text(message))
    }
}
