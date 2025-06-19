//
//  ProfilePresenter.swift
//  OpenVK Swift
//
//  Created by Ry0 on 15.06.2025.
//

import Foundation

class ProfilePresenter: ObservableObject {
    
    @Published var profile: Profile?
    
    @Published var lastSeen = "Никогда"
    
    let client = OVKClient()
    
    init() {
        client.request(.accountSetOnline) { (_: Result<[Profile], APIError>) in
            self.client.request(.usersGetMe(fields: ["is_closed","can_access_closed","verified","sex","has_photo","photo_200","status","screen_name","friend_status","last_seen","music","movies","tv","books","city","interest","quotes","email","telegram","about","rating","correct_counters","reg_date","is_dead","nickname","blacklisted","blacklisted_by_me","bdate"])) { (result: Result<[Profile], APIError>) in // Если чето обосрётся, убрать bdate
                DispatchQueue.main.async {
                    switch result {
                    case .success(let profiles):
                        self.profile = profiles.first
                        if (self.profile?.online == 0) {
                            if let lastSeenTime = self.profile?.lastSeen?.time, lastSeenTime != 0 {
                                self.lastSeen = "\(convertTimestampToStatus(lastSeenTime, sex: self.profile?.sex ?? 0)) \(getPlatform(platform_integer: self.profile?.lastSeen?.platform ?? 0))"
                            } else {
                                self.lastSeen = getLocalizedString(key: "Никогда")
                            }
                        } else {
                            self.lastSeen = "\(getLocalizedString(key: "online").capitalizedSentence) \(getPlatform(platform_integer: self.profile?.lastSeen?.platform ?? 0))"
                        }
                    case .failure(let error):
                        print("Ошибка API \(error.error_code): \(error.error_msg)")
                    }
                }
            }
        }
        
        
    }
    
    func profileStats(from counters: Counters) -> [(title: String, value: Int)] {
        return [
            ("Друзья", counters.friends ?? 0),
            ("Подписчики", 0),
            ("Группы", counters.groups ?? 0),
            ("Фотографии", counters.photos ?? 0),
            ("Музыка", counters.audios ?? 0),
            ("Видео", counters.videos ?? 0)
        ]
    }
    
    func profileAdditionalInfo(from profile: Profile) -> [(category: String, value: [(title: String, value: String)])] {
        return [
            ("Основное", [
                ("Обо мне", profile.about ?? ""),
                ("Рейтинг", "\(profile.rating ?? 0)%"),
                ("Дата регистрации", convertTimestampToDate(timestamp: profile.regDate ?? 0)),
            ]),
            ("Контакты", [
                ("Город", profile.city ?? ""),
                ("Почта", profile.email ?? ""),
                ("Телеграм", profile.telegram ?? ""),
            ]),
            ("Интересы", [
                ("Любимая музыка", profile.music ?? ""),
                ("Любимые фильмы", profile.movies ?? ""),
                ("Любимые передачи", profile.tv ?? ""),
                ("Любимые книги", profile.books ?? ""),
                ("Любимые цитаты", profile.quotes ?? ""),
            ]),
        ]
    }
    
    func getMe() {
        profile = nil
        client.request(.usersGetMe(fields: ["is_closed","can_access_closed","verified","sex","has_photo","photo_200","status","screen_name","friend_status","last_seen","music","movies","tv","books","city","interest","quotes","email","telegram","about","rating","correct_counters","reg_date","is_dead","nickname","blacklisted","blacklisted_by_me","bdate"])) { (result: Result<[Profile], APIError>) in
            switch result {
            case .success(let profiles):
                DispatchQueue.main.async {
                    self.profile = profiles.first
                    if (self.profile?.online == 0) {
                        if let lastSeenTime = self.profile?.lastSeen?.time, lastSeenTime != 0 {
                            self.lastSeen = "\(convertTimestampToStatus(lastSeenTime, sex: self.profile?.sex ?? 0)) \(getPlatform(platform_integer: self.profile?.lastSeen?.platform ?? 0))"
                        } else {
                            self.lastSeen = getLocalizedString(key: "Никогда")
                        }
                    } else {
                        self.lastSeen = "\(getLocalizedString(key: "online").capitalizedSentence) \(getPlatform(platform_integer: self.profile?.lastSeen?.platform ?? 0))"
                    }
                }
            case .failure(let error):
                print("Ошибка API \(error.error_code): \(error.error_msg)")
            }
        }
        client.request(.accountSetOnline){(result: Result<[Profile], APIError>) in}
    }
    
    
    
}

extension ProfilePresenter {
    static var mock: ProfilePresenter {
        let presenter = ProfilePresenter()
        return presenter
    }
}
