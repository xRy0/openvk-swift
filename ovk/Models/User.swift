//
//  User.swift
//  OpenVK Swift
//
//  Created by Ry0 on 26.01.2025.
//

import Foundation

struct User: Codable {

  var firstName          : String? = nil
  var photo200           : String? = nil
  var nickname           : String? = nil
  var isServiceAccount   : Bool?   = nil
  var id                 : Int?    = nil
  var isVerified         : Bool?   = nil
  var verificationStatus : String? = nil
  var lastName           : String? = nil
  var homeTown           : String? = nil
  var status             : String? = nil
  var bdate              : String? = nil
  var bdateVisibility    : Int?    = nil
  var phone              : String? = nil
  var relation           : Int?    = nil
  var screenName         : String? = nil
  var sex                : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case firstName          = "first_name"
    case photo200           = "photo_200"
    case nickname           = "nickname"
    case isServiceAccount   = "is_service_account"
    case id                 = "id"
    case isVerified         = "is_verified"
    case verificationStatus = "verification_status"
    case lastName           = "last_name"
    case homeTown           = "home_town"
    case status             = "status"
    case bdate              = "bdate"
    case bdateVisibility    = "bdate_visibility"
    case phone              = "phone"
    case relation           = "relation"
    case screenName         = "screen_name"
    case sex                = "sex"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    firstName          = try values.decodeIfPresent(String.self , forKey: .firstName          )
    photo200           = try values.decodeIfPresent(String.self , forKey: .photo200           )
    nickname           = try values.decodeIfPresent(String.self , forKey: .nickname           )
    isServiceAccount   = try values.decodeIfPresent(Bool.self   , forKey: .isServiceAccount   )
    id                 = try values.decodeIfPresent(Int.self    , forKey: .id                 )
    isVerified         = try values.decodeIfPresent(Bool.self   , forKey: .isVerified         )
    verificationStatus = try values.decodeIfPresent(String.self , forKey: .verificationStatus )
    lastName           = try values.decodeIfPresent(String.self , forKey: .lastName           )
    homeTown           = try values.decodeIfPresent(String.self , forKey: .homeTown           )
    status             = try values.decodeIfPresent(String.self , forKey: .status             )
    bdate              = try values.decodeIfPresent(String.self , forKey: .bdate              )
    bdateVisibility    = try values.decodeIfPresent(Int.self    , forKey: .bdateVisibility    )
    phone              = try values.decodeIfPresent(String.self , forKey: .phone              )
    relation           = try values.decodeIfPresent(Int.self    , forKey: .relation           )
    screenName         = try values.decodeIfPresent(String.self , forKey: .screenName         )
    sex                = try values.decodeIfPresent(Int.self    , forKey: .sex                )
 
  }

  init() {

  }

}
