//
//  WallPosts.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

struct CopyHistory: Codable {

  var pid         : Int?        = nil
  var fromId      : Int?        = nil
  var ownerId     : Int?        = nil
  var date        : Int?        = nil
  var postType    : String?     = nil
  var text        : String?     = nil
  var canEdit     : Bool?       = nil
  var canDelete   : Bool?       = nil
  var canPin      : Bool?       = nil
  var canArchive  : Bool?       = nil
  var isArchived  : Bool?       = nil
  var isPinned    : Bool?       = nil
  var isExplicit  : Bool?       = nil
  var attachments : [PostAttachmentsModel]?   = []
  var postSource  : PostSource? = PostSource()
  var comments    : Comments?   = Comments()
  var likes       : Likes?      = Likes()
  var reposts     : Reposts?    = Reposts()

  enum CodingKeys: String, CodingKey {

    case pid         = "id"
    case fromId      = "from_id"
    case ownerId     = "owner_id"
    case date        = "date"
    case postType    = "post_type"
    case text        = "text"
    case canEdit     = "can_edit"
    case canDelete   = "can_delete"
    case canPin      = "can_pin"
    case canArchive  = "can_archive"
    case isArchived  = "is_archived"
    case isPinned    = "is_pinned"
    case isExplicit  = "is_explicit"
    case attachments = "attachments"
    case postSource  = "post_source"
    case comments    = "comments"
    case likes       = "likes"
    case reposts     = "reposts"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    pid         = try values.decodeIfPresent(Int.self        , forKey: .pid         )
    fromId      = try values.decodeIfPresent(Int.self        , forKey: .fromId      )
    ownerId     = try values.decodeIfPresent(Int.self        , forKey: .ownerId     )
    date        = try values.decodeIfPresent(Int.self        , forKey: .date        )
    postType    = try values.decodeIfPresent(String.self     , forKey: .postType    )
    text        = try values.decodeIfPresent(String.self     , forKey: .text        )
    canEdit     = try values.decodeIfPresent(Bool.self       , forKey: .canEdit     )
    canDelete   = try values.decodeIfPresent(Bool.self       , forKey: .canDelete   )
    canPin      = try values.decodeIfPresent(Bool.self       , forKey: .canPin      )
    canArchive  = try values.decodeIfPresent(Bool.self       , forKey: .canArchive  )
    isArchived  = try values.decodeIfPresent(Bool.self       , forKey: .isArchived  )
    isPinned    = try values.decodeIfPresent(Bool.self       , forKey: .isPinned    )
    isExplicit  = try values.decodeIfPresent(Bool.self       , forKey: .isExplicit  )
    attachments = try values.decodeIfPresent([PostAttachmentsModel].self   , forKey: .attachments )
    postSource  = try values.decodeIfPresent(PostSource.self , forKey: .postSource  )
    comments    = try values.decodeIfPresent(Comments.self   , forKey: .comments    )
    likes       = try values.decodeIfPresent(Likes.self      , forKey: .likes       )
    reposts     = try values.decodeIfPresent(Reposts.self    , forKey: .reposts     )
 
  }

  init() {

  }

}
