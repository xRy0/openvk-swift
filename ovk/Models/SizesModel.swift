//
//  SizesModel.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct SizesModel: Codable {

  var url    : String? = nil
  var width  : Int?    = nil
  var height : Int?    = nil
  var crop   : Bool?   = nil
  var type   : String? = nil

  enum CodingKeys: String, CodingKey {

    case url    = "url"
    case width  = "width"
    case height = "height"
    case crop   = "crop"
    case type   = "type"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    url    = try values.decodeIfPresent(String.self , forKey: .url    )
    width  = try values.decodeIfPresent(Int.self    , forKey: .width  )
    height = try values.decodeIfPresent(Int.self    , forKey: .height )
    crop   = try values.decodeIfPresent(Bool.self   , forKey: .crop   )
    type   = try values.decodeIfPresent(String.self , forKey: .type   )
 
  }

  init() {

  }

}
