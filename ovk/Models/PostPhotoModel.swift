//
//  PostPhotoModel.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct PostPhotoModel: Codable {

  var albumId : Int?     = nil
  var date    : Int?     = nil
  var id      : Int?     = nil
  var ownerId : Int?     = nil
  var sizes   : [SizesModel]? = []
  var text    : String?  = nil
  var hasTags : Bool?    = nil

  enum CodingKeys: String, CodingKey {

    case albumId = "album_id"
    case date    = "date"
    case id      = "id"
    case ownerId = "owner_id"
    case sizes   = "sizes"
    case text    = "text"
    case hasTags = "has_tags"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    albumId = try values.decodeIfPresent(Int.self     , forKey: .albumId )
    date    = try values.decodeIfPresent(Int.self     , forKey: .date    )
    id      = try values.decodeIfPresent(Int.self     , forKey: .id      )
    ownerId = try values.decodeIfPresent(Int.self     , forKey: .ownerId )
    sizes   = try values.decodeIfPresent([SizesModel].self , forKey: .sizes   )
    text    = try values.decodeIfPresent(String.self  , forKey: .text    )
    hasTags = try values.decodeIfPresent(Bool.self    , forKey: .hasTags )
 
  }

  init() {

  }

}
