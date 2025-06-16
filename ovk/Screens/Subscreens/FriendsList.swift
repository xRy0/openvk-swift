//
//  FriendsList.swift
//  OpenVK Swift
//
//  Created by Isami Riša on 07.11.2023.
//

import SwiftUI

struct FriendsList: View {
    
    @Binding var debug: Bool
    @Binding var isMainViewUpdated: Bool
    
    @Binding var userIDtoGet: String
    @Binding var friends: [[String: Any]]
    
    @Binding var imageURL: String
    @Binding var viewerShown: Bool
    
    
    
    var body: some View {
        Form {
            Text("frindlist")
        }
    }
}
