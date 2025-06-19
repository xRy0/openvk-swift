//
//  Reposts.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct Reposts: Codable {

  var count        : Int? = nil
  var userReposted : Int? = nil

  enum CodingKeys: String, CodingKey {

    case count        = "count"
    case userReposted = "user_reposted"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    count        = try values.decodeIfPresent(Int.self , forKey: .count        )
    userReposted = try values.decodeIfPresent(Int.self , forKey: .userReposted )
 
  }

  init() {

  }

}
