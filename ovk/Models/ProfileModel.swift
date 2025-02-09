//
//  ProfileModel.swift
//  OpenVK Swift
//
//  Created by Ry0 on 10.02.2025.
//

import Foundation

// Основная структура для всего объекта
struct ProfileObject: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let isClosed: Bool
    let canAccessClosed: Bool
    let status: String
    let statusAudio: StatusAudio?
    let photo200: String
    let lastSeen: LastSeen
    let music: String?
    let sex: Int
    let movies: String?
    let tv: String?
    let books: String?
    let city: String
    let interests: String
    let verified: Int
    let about: String?
    let email: String
    let quotes: String?
    let telegram: String
    let online: Int
    
    // Кодирование ключей (чтобы соответствовать JSON)
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case status
        case statusAudio = "status_audio"
        case photo200 = "photo_200"
        case lastSeen = "last_seen"
        case music
        case sex
        case movies
        case tv
        case books
        case city
        case interests
        case verified
        case about
        case email
        case quotes
        case telegram
        case online
    }
    
}

// Вложенная структура для status_audio
struct StatusAudio: Codable {
    let uniqueId: String
    let aid: Int
    let id: Int
    let artist: String
    let title: String
    let duration: Int
    let album: String?
    let albumId: Int?
    let url: String
    let manifest: String
    let keys: [String: String]
    let genre: Int
    let genreId: Int
    let genreStr: String
    let ownerId: Int
    let lyrics: String?
    let added: Bool
    let editable: Bool
    let searchable: Bool
    let explicit: Bool
    let withdrawn: Bool
    let ready: Bool
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
        case aid
        case id
        case artist
        case title
        case duration
        case album
        case albumId = "album_id"
        case url
        case manifest
        case keys
        case genre
        case genreId = "genre_id"
        case genreStr = "genre_str"
        case ownerId = "owner_id"
        case lyrics
        case added
        case editable
        case searchable
        case explicit
        case withdrawn
        case ready
    }
}

// Вложенная структура для last_seen
struct LastSeen: Codable {
    let platform: Int
    let time: Int
}
