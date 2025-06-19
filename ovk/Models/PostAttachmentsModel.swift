//
//  PostAttachmentsModel.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct PostAttachmentsModel: Codable {

  var type  : String? = nil
  var photo : PostPhotoModel?  = PostPhotoModel()

  enum CodingKeys: String, CodingKey {

    case type  = "type"
    case photo = "photo"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    type  = try values.decodeIfPresent(String.self , forKey: .type  )
    photo = try values.decodeIfPresent(PostPhotoModel.self  , forKey: .photo )
 
  }

  init() {

  }

}
