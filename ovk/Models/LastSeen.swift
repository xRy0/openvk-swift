//
//  LastSeen.swift
//  OpenVK Swift
//
//  Created by Ry0 on 15.06.2025.
//

import Foundation

struct LastSeen: Codable {

  var platform : Int? = nil
  var time     : Int? = nil

  enum CodingKeys: String, CodingKey {

    case platform = "platform"
    case time     = "time"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    platform = try values.decodeIfPresent(Int.self , forKey: .platform )
    time     = try values.decodeIfPresent(Int.self , forKey: .time     )
 
  }

  init() {

  }

}
