//
//  PostsProfiles.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct PostsProfiles: Codable {

  var firstName       : String? = nil
  var id              : Int?    = nil
  var lastName        : String? = nil
  var canAccessClosed : Bool?   = nil
  var isClosed        : Bool?   = nil
  var sex             : Int?    = nil
  var screenName      : String? = nil
  var photo50         : String? = nil
  var photo100        : String? = nil
  var online          : Bool?   = nil
  var verified        : Bool?   = nil

  enum CodingKeys: String, CodingKey {

    case firstName       = "first_name"
    case id              = "id"
    case lastName        = "last_name"
    case canAccessClosed = "can_access_closed"
    case isClosed        = "is_closed"
    case sex             = "sex"
    case screenName      = "screen_name"
    case photo50         = "photo_50"
    case photo100        = "photo_100"
    case online          = "online"
    case verified        = "verified"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    firstName       = try values.decodeIfPresent(String.self , forKey: .firstName       )
    id              = try values.decodeIfPresent(Int.self    , forKey: .id              )
    lastName        = try values.decodeIfPresent(String.self , forKey: .lastName        )
    canAccessClosed = try values.decodeIfPresent(Bool.self   , forKey: .canAccessClosed )
    isClosed        = try values.decodeIfPresent(Bool.self   , forKey: .isClosed        )
    sex             = try values.decodeIfPresent(Int.self    , forKey: .sex             )
    screenName      = try values.decodeIfPresent(String.self , forKey: .screenName      )
    photo50         = try values.decodeIfPresent(String.self , forKey: .photo50         )
    photo100        = try values.decodeIfPresent(String.self , forKey: .photo100        )
    online          = try values.decodeIfPresent(Bool.self   , forKey: .online          )
    verified        = try values.decodeIfPresent(Bool.self   , forKey: .verified        )
 
  }

  init() {

  }

}
