//
//  Counters.swift
//  OpenVK Swift
//
//  Created by Ry0 on 15.06.2025.
//

import Foundation

struct Counters: Codable {

  var friends       : Int? = nil
  var photos        : Int? = nil
  var videos        : Int? = nil
  var audios        : Int? = nil
  var notes         : Int? = nil
  var groups        : Int? = nil
  var onlineFriends : Int? = nil

  enum CodingKeys: String, CodingKey {

    case friends       = "friends"
    case photos        = "photos"
    case videos        = "videos"
    case audios        = "audios"
    case notes         = "notes"
    case groups        = "groups"
    case onlineFriends = "online_friends"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    friends       = try values.decodeIfPresent(Int.self , forKey: .friends       )
    photos        = try values.decodeIfPresent(Int.self , forKey: .photos        )
    videos        = try values.decodeIfPresent(Int.self , forKey: .videos        )
    audios        = try values.decodeIfPresent(Int.self , forKey: .audios        )
    notes         = try values.decodeIfPresent(Int.self , forKey: .notes         )
    groups        = try values.decodeIfPresent(Int.self , forKey: .groups        )
    onlineFriends = try values.decodeIfPresent(Int.self , forKey: .onlineFriends )
 
  }

  init() {

  }

}
