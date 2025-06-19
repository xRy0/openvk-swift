//
//  Likes.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct Likes: Codable {

  var count      : Int? = nil
  var userLikes  : Int? = nil
  var canLike    : Int? = nil
  var canPublish : Int? = nil

  enum CodingKeys: String, CodingKey {

    case count      = "count"
    case userLikes  = "user_likes"
    case canLike    = "can_like"
    case canPublish = "can_publish"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    count      = try values.decodeIfPresent(Int.self , forKey: .count      )
    userLikes  = try values.decodeIfPresent(Int.self , forKey: .userLikes  )
    canLike    = try values.decodeIfPresent(Int.self , forKey: .canLike    )
    canPublish = try values.decodeIfPresent(Int.self , forKey: .canPublish )
 
  }

  init() {

  }

}
