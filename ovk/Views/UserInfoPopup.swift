//
//  Popup.swift
//  OpenVK Swift
//
//  Created by Ry0 on 02.11.2023.
//

import Foundation
import SwiftUI
import WebKit

struct UserInfoPopup: View {
    @Binding var profileObject: ProfileObject?
    
    var sex_values: [Int: String] = [
        0: "они/их",
        1: "она/её",
        2: "он/его"
    ]
    
    var body: some View {
        Form {
            Section {
                if let email = profileObject?.email, !email.isEmpty {
                    VStack(alignment: .leading) {
                        Text("E-mail")
                            .font(.callout.smallCaps())
                            .foregroundStyle(.secondary)
                        Text(email)
                    }
                }
                
                if let telegram = profileObject?.telegram, !telegram.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Telegram")
                            .font(.callout.smallCaps())
                            .foregroundStyle(.secondary)
                        Text(telegram)
                    }
                }
                
                if let city = profileObject?.city, !city.isEmpty {
                    Section {
                        VStack(alignment: .leading) {
                            Text("Город")
                                .font(.callout.smallCaps())
                                .foregroundStyle(.secondary)
                            Text(city)
                        }
                    }
                }
            }.modifier(FormElevateOnWhiteBackground())
            
            Section {
                if let interests = profileObject?.interests, !interests.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Интересы")
                            .font(.callout.smallCaps())
                            .foregroundStyle(.secondary)
                        Text(interests)
                    }
                }
                
                if let music = profileObject?.music, !music.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Любимая музыка")
                            .font(.callout.smallCaps())
                            .foregroundStyle(.secondary)
                        Text(music)
                    }
                }
                
                if let movies = profileObject?.movies, !movies.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Любимые фильмы")
                            .font(.callout.smallCaps())
                            .foregroundStyle(.secondary)
                        Text(movies)
                    }
                }
                
                if let tv = profileObject?.tv, !tv.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Любимые ТВ-шоу")
                            .font(.callout.smallCaps())
                            .foregroundStyle(.secondary)
                        Text(tv)
                    }
                }
                
                if let books = profileObject?.books, !books.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Любимые книги")
                            .font(.callout.smallCaps())
                            .foregroundStyle(.secondary)
                        Text(books)
                    }
                }
                
                if let quotes = profileObject?.quotes, !quotes.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Любимые цитаты")
                            .font(.callout.smallCaps())
                            .foregroundStyle(.secondary)
                        Text(quotes)
                    }
                }
                
                if let about = profileObject?.about, !about.isEmpty {
                    VStack(alignment: .leading) {
                        Text("О себе")
                            .font(.callout.smallCaps())
                            .foregroundStyle(.secondary)
                        Text(about)
                    }
                }
            }.modifier(FormElevateOnWhiteBackground())
            
            Section {
                VStack(alignment: .leading) {
                    Text("Местоимения")
                        .font(.callout.smallCaps())
                        .foregroundStyle(.secondary)
                    Text(sex_values[profileObject?.sex ?? 0] ?? "Неизвестно")
                }
            }.modifier(FormElevateOnWhiteBackground())
        }
    }
}
