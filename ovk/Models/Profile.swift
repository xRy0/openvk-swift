//
//  Profile.swift
//  OpenVK Swift
//
//  Created by Ry0 on 15.06.2025.
//

import Foundation

struct Profile: Codable {

  var id              : Int?      = nil
  var firstName       : String?   = nil
  var lastName        : String?   = nil
  var isClosed        : Bool?     = nil
  var canAccessClosed : Bool?     = nil
  var verified        : Int?      = nil
  var sex             : Int?      = nil
  var hasPhoto        : Int?      = nil
  var photo200        : String?   = nil
  var status          : String?   = nil
  var screenName      : String?   = nil
  var friendStatus    : Int?      = nil
  var lastSeen        : LastSeen? = LastSeen()
  var music           : String?   = nil
  var movies          : String?   = nil
  var tv              : String?   = nil
  var books           : String?   = nil
  var city            : String?   = nil
  var quotes          : String?   = nil
  var email           : String?   = nil
  var telegram        : String?   = nil
  var about           : String?   = nil
  var rating          : Int?      = nil
  var counters        : Counters? = Counters()
  var regDate         : Int?      = nil
  var isDead          : Bool?     = nil
  var nickname        : String?   = nil
  var blacklisted     : Int?      = nil
  var blacklistedByMe : Int?      = nil
  var online          : Int?      = nil

  enum CodingKeys: String, CodingKey {

    case id              = "id"
    case firstName       = "first_name"
    case lastName        = "last_name"
    case isClosed        = "is_closed"
    case canAccessClosed = "can_access_closed"
    case verified        = "verified"
    case sex             = "sex"
    case hasPhoto        = "has_photo"
    case photo200        = "photo_200"
    case status          = "status"
    case screenName      = "screen_name"
    case friendStatus    = "friend_status"
    case lastSeen        = "last_seen"
    case music           = "music"
    case movies          = "movies"
    case tv              = "tv"
    case books           = "books"
    case city            = "city"
    case quotes          = "quotes"
    case email           = "email"
    case telegram        = "telegram"
    case about           = "about"
    case rating          = "rating"
    case counters        = "counters"
    case regDate         = "reg_date"
    case isDead          = "is_dead"
    case nickname        = "nickname"
    case blacklisted     = "blacklisted"
    case blacklistedByMe = "blacklisted_by_me"
    case online          = "online"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id              = try values.decodeIfPresent(Int.self      , forKey: .id              )
    firstName       = try values.decodeIfPresent(String.self   , forKey: .firstName       )
    lastName        = try values.decodeIfPresent(String.self   , forKey: .lastName        )
    isClosed        = try values.decodeIfPresent(Bool.self     , forKey: .isClosed        )
    canAccessClosed = try values.decodeIfPresent(Bool.self     , forKey: .canAccessClosed )
    verified        = try values.decodeIfPresent(Int.self      , forKey: .verified        )
    sex             = try values.decodeIfPresent(Int.self      , forKey: .sex             )
    hasPhoto        = try values.decodeIfPresent(Int.self      , forKey: .hasPhoto        )
    photo200        = try values.decodeIfPresent(String.self   , forKey: .photo200        )
    status          = try values.decodeIfPresent(String.self   , forKey: .status          )
    screenName      = try values.decodeIfPresent(String.self   , forKey: .screenName      )
    friendStatus    = try values.decodeIfPresent(Int.self      , forKey: .friendStatus    )
    lastSeen        = try values.decodeIfPresent(LastSeen.self , forKey: .lastSeen        )
    music           = try values.decodeIfPresent(String.self   , forKey: .music           )
    movies          = try values.decodeIfPresent(String.self   , forKey: .movies          )
    tv              = try values.decodeIfPresent(String.self   , forKey: .tv              )
    books           = try values.decodeIfPresent(String.self   , forKey: .books           )
    city            = try values.decodeIfPresent(String.self   , forKey: .city            )
    quotes          = try values.decodeIfPresent(String.self   , forKey: .quotes          )
    email           = try values.decodeIfPresent(String.self   , forKey: .email           )
    telegram        = try values.decodeIfPresent(String.self   , forKey: .telegram        )
    about           = try values.decodeIfPresent(String.self   , forKey: .about           )
    rating          = try values.decodeIfPresent(Int.self      , forKey: .rating          )
    counters        = try values.decodeIfPresent(Counters.self , forKey: .counters        )
    regDate         = try values.decodeIfPresent(Int.self      , forKey: .regDate         )
    isDead          = try values.decodeIfPresent(Bool.self     , forKey: .isDead          )
    nickname        = try values.decodeIfPresent(String.self   , forKey: .nickname        )
    blacklisted     = try values.decodeIfPresent(Int.self      , forKey: .blacklisted     )
    blacklistedByMe = try values.decodeIfPresent(Int.self      , forKey: .blacklistedByMe )
    online          = try values.decodeIfPresent(Int.self      , forKey: .online          )
 
  }

  init() {

  }

}
