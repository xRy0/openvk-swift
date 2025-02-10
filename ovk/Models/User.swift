//
//  User.swift
//  OpenVK Swift
//
//  Created by Ry0 on 26.01.2025.
//

import Foundation

struct User {
    var id: Int
    var firstName: String
    var lastName: String
    var status: String
    var verified: Bool
    var photoURL: String
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
              let firstName = dictionary["first_name"] as? String,
              let lastName = dictionary["last_name"] as? String,
              let status = dictionary["status"] as? String,
              let verified = dictionary["verified"] as? Int,
              let photoURL = dictionary["photo_50"] as? String else {
            return nil
        }
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.status = status
        self.verified = verified != 0
        self.photoURL = photoURL
    }
}
