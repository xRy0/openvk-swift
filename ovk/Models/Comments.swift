//
//  Comments.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct Comments: Codable {

  var count   : Int? = nil
  var canPost : Int? = nil

  enum CodingKeys: String, CodingKey {

    case count   = "count"
    case canPost = "can_post"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    count   = try values.decodeIfPresent(Int.self , forKey: .count   )
    canPost = try values.decodeIfPresent(Int.self , forKey: .canPost )
 
  }

  init() {

  }

}
