//
//  PostSource.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct PostSource: Codable {

  var type : String? = nil

  enum CodingKeys: String, CodingKey {

    case type = "type"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    type = try values.decodeIfPresent(String.self , forKey: .type )
 
  }

  init() {

  }

}
