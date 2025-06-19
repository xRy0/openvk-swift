//
//  Wall.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct Wall: Codable {

  var count    : Int?        = nil
  var items    : [WallPosts]?    = []
  var profiles : [PostsProfiles]? = []
  var groups   : [GroupModel]?   = []

  enum CodingKeys: String, CodingKey {

    case count    = "count"
    case items    = "items"
    case profiles = "profiles"
    case groups   = "groups"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    count    = try values.decodeIfPresent(Int.self        , forKey: .count    )
    items    = try values.decodeIfPresent([WallPosts].self    , forKey: .items    )
    profiles = try values.decodeIfPresent([PostsProfiles].self , forKey: .profiles )
    groups   = try values.decodeIfPresent([GroupModel].self   , forKey: .groups   )
 
  }

  init() {

  }

}
