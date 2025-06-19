//
//  GroupModel.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct GroupModel: Codable {

  var id         : Int?    = nil
  var name       : String? = nil
  var screenName : String? = nil
  var isClosed   : Int?    = nil
  var type       : String? = nil
  var photo50    : String? = nil
  var photo100   : String? = nil
  var photo200   : String? = nil
  var verified   : Bool?   = nil

  enum CodingKeys: String, CodingKey {

    case id         = "id"
    case name       = "name"
    case screenName = "screen_name"
    case isClosed   = "is_closed"
    case type       = "type"
    case photo50    = "photo_50"
    case photo100   = "photo_100"
    case photo200   = "photo_200"
    case verified   = "verified"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id         = try values.decodeIfPresent(Int.self    , forKey: .id         )
    name       = try values.decodeIfPresent(String.self , forKey: .name       )
    screenName = try values.decodeIfPresent(String.self , forKey: .screenName )
    isClosed   = try values.decodeIfPresent(Int.self    , forKey: .isClosed   )
    type       = try values.decodeIfPresent(String.self , forKey: .type       )
    photo50    = try values.decodeIfPresent(String.self , forKey: .photo50    )
    photo100   = try values.decodeIfPresent(String.self , forKey: .photo100   )
    photo200   = try values.decodeIfPresent(String.self , forKey: .photo200   )
    verified   = try values.decodeIfPresent(Bool.self   , forKey: .verified   )
 
  }

  init() {

  }

}
