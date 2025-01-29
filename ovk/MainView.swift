//
//  SwiftUIView.swift
//  ovk
//
//  Created by Isami Riša on 25.10.2023.
//

import SwiftUI

struct MainView: View {
    @State private var debug = false
    @State private var isMainViewUpdated = false
    
    var body: some View {
        Group {
            if AuthenticationManager.shared.isUserLoggedIn() {
                MainScreen(isMainViewUpdated: $isMainViewUpdated, debug: $debug)
            } else {
                LoginView(debug: $debug, isMainViewUpdated: $isMainViewUpdated)
            }
        }
        .background(isMainViewUpdated ? Color.clear : Color.clear)
    }
}

#Preview {
    MainView()
}
