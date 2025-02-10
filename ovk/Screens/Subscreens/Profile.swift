//
//  Profile.swift
//  ovk
//
//  Created by Isami Riša on 25.10.2023.
//

import SwiftUI

struct Profile: View {
    
    @Binding var debug: Bool
    @Binding var isMainViewUpdated: Bool
    @Binding var profileHeader: String
    
    @State var loadEnded = false
    
    @State var isMoreInfoPopupOpened = false
    
    @State var postsLoadingFinished = false
    @State var postsOffset = 1
    
    @State var error = false
    @State var errorReason = ""
    
    @State var jsonData = [:]
    @State var profileObject: ProfileObject? = nil
    @State var name = getLocalizedString(key: "Loading...")
    @State var lastSeen = ""
    
    @State var posts = []
    @State var postsProfiles = []
    
    @State var counts = [
        "friends": "",
        "followers": "",
        "groups": "",
        "albums": ""
    ]
    
    @State var friends: [[String: Any]] = [[:]]
    
    @State var userIDtoGet: String
    
    @Binding var imageURL: String
    @Binding var viewerShown: Bool
    
    @State private var showSheet = false
    @State private var postText: String = ""

    
    func clearProfileVariables() {
        isMoreInfoPopupOpened = false
        error = false
        errorReason = ""
        
        jsonData = [:]
        
        name = getLocalizedString(key: "Loading...")
        
        lastSeen = ""
        
        
        posts = []
        postsProfiles = []
        
        counts = [
            "friends": "",
            "followers": "",
            "groups": "",
            "albums": ""
        ]
        
        friends = [[:]]
        
        postsLoadingFinished = false
        postsOffset = 1
        
    }
    
    func refresh() {
        loadEnded = false
        clearProfileVariables()
        loadProfileData()
    }
    
    func getPlatform(platform_integer: Int) -> String {
        switch (platform_integer) {
        case 2:
            return "\(getLocalizedString(key: "from")) iPhone"
        case 4:
            return "\(getLocalizedString(key: "from")) Android"
        case 7:
            return ""
        default:
            return "\(getLocalizedString(key: "from")) API"
        }
    }
    
    func loadProfileData() {
        profileHeader = name
        if !loadEnded {
            CallAPI(function: "Account.getProfileInfo", completion: afterGetProfileInfoLoad)
        }
    }
    
    func newPost(text: String) {
        CallAPI(function: "wall.post", params: ["owner_id": userIDtoGet, "message": text], completion: afterNewPostGetLoad)
        showSheet = false
        postText = ""
    }
    
    func afterGetProfileInfoLoad(data: [String: Any]?) {
        if (data?["error_msg"] != nil) {
            error = true
            errorReason = data!["error_msg"] as! String
        }
        error = false
        
        let response = data?["response"] as? [String: Any]
        if userIDtoGet == "0" {
            userIDtoGet = String(response?["id"] as? Int ?? 0)
            if userIDtoGet == "0" {
                error = true
                errorReason = "Ошибка загрузки ID"
            }
        }
        
        CallAPI(function: "Users.get", params: ["fields": "status,photo_200,last_seen,online,sex,music,movies,tv,books,city,interests,verified,about,email,quotes,telegram", "user_ids": userIDtoGet], completion: afterProfileDataLoad)
        CallAPI(function: "Friends.get", params: ["user_id": userIDtoGet, "count": "11"], completion: afterFriendsGetLoad)
        CallAPI(function: "Users.getFollowers", params: ["user_id": userIDtoGet, "count": "11"], completion: afterFollowersGetLoad)
        CallAPI(function: "Groups.get", params: ["user_id": userIDtoGet], completion: afterGroupsGetLoad)
        CallAPI(function: "Photos.getAlbums", params: ["owner_id": userIDtoGet], completion: afterAlbumsGetLoad)
        CallAPI(function: "Wall.get", params: ["owner_id": userIDtoGet, "extended": "1", "count": "5"], completion: afterPostsGetLoad)
    }
    
    func afterProfileDataLoad(data: [String: Any]?) {
        if let errorMsg = data?["error_msg"] as? String {
            error = true
            errorReason = errorMsg
        }
        
        if let responseArray = data?["response"] as? [[String: Any]] {
            guard let userInfo = responseArray.first else { return }
            
            // Преобразуем словарь в Data
            if let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: []) {
                do {
                    print("!!! DATA GAINED")
                    // Декодируем данные
                    profileObject = try JSONDecoder().decode(ProfileObject.self, from: jsonData)
                    
                    
                    if profileObject?.online == 0 {
                        if let lastSeenTime = profileObject?.lastSeen?.time, lastSeenTime != 0 {
                            lastSeen = "\(convertTimestampToStatus(lastSeenTime, sex: profileObject?.sex ?? 0)) \(getPlatform(platform_integer: profileObject?.lastSeen?.platform ?? 0))"
                        } else {
                            lastSeen = getLocalizedString(key: "Никогда")
                        }
                    } else {
                        lastSeen = "\(getLocalizedString(key: "online").capitalizedSentence) \(getPlatform(platform_integer: profileObject?.lastSeen?.platform ?? 0))"
                    }
                    name = "\(profileObject?.firstName ?? "") \(profileObject?.lastName ?? "")"
                    
                    loadEnded = true
                } catch {
                    print("Ошибка декодирования: \(error)")
                }
            } else {
                print("Не удалось преобразовать словарь в Data")
            }
        }
    }
    
    func setCount(data: [String: Any]?, counterName: String) {
        if (data?["error_msg"] != nil) {
            counts[counterName] = "error"
        }
        let response = data?["response"] as? [String: Any]
        let CountInt = response?["count"] as? Int ?? -1
        if CountInt == -1 {
            counts[counterName] = "error"
        } else {
            counts[counterName] = String(CountInt)
        }
    }
    
    func afterFriendsGetLoad(data: [String: Any]?) {
        setCount(data: data, counterName: "friends")
        
        let response = data?["response"] as? [String: Any]
        friends = response?["items"] as? [[String: Any]] ?? [[:]]
    }
    
    func afterFollowersGetLoad(data: [String: Any]?) {
        setCount(data: data, counterName: "followers")
    }
    
    func afterGroupsGetLoad(data: [String: Any]?) {
        setCount(data: data, counterName: "groups")
    }
    
    func afterAlbumsGetLoad(data: [String: Any]?) {
        setCount(data: data, counterName: "albums")
    }
    
    func afterPostsGetLoad(data: [String: Any]?) {
        let response = data?["response"] as? [String: Any]
        posts = response?["items"] as? [Any] ?? []
        postsProfiles = response?["profiles"] as? [Any] ?? []
        
    }
    
    func afterNewPostGetLoad(data: [String: Any]?) {
        refresh()
    }
    
    func afterAdditionalPostsGetLoad(data: [String: Any]?) {
        let response = data?["response"] as? [String: Any]
        let postsObj = response?["items"] as? [Any] ?? []
        if postsObj.count == 0 {
            postsLoadingFinished = true
        }
        posts += postsObj
        postsProfiles += response?["profiles"] as? [Any] ?? []
    }
    
    var body: some View {
        Form {
            if !error {
                if debug {
                    Section {
                        Text("User ID:")
                        TextField("ID", text: $userIDtoGet)
                        Button ("Получить/обновить страницу") {
                            refresh()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        Text("Sex: \(profileObject?.sex)")
                    } header: {
                        Text("Debug")
                    }
                }
                
                Section {
                    HStack (alignment: .top, spacing: 20) {
                        AsyncImage(url: URL(string: profileObject?.photo200 ?? (getValueFromUserDefaults(forKey: "instance") ?? "https://ovk.to") + "/assets/packages/static/openvk/img/camera_200.png")) { image in image.resizable().scaledToFill() }
                    placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        VStack (alignment: .leading) {
                            HStack {
                                Text(name)
                                    .font(.headline)
                                if (profileObject?.verified != 0) {
                                    Image(systemName: "checkmark")
                                }
                            }
                            Text(lastSeen)
                                .font(.subheadline)
                                .foregroundColor((profileObject?.online != 0) ? .primary : .secondary)
                            Spacer()
                                .frame(height: 15)
                            Text(profileObject?.status ?? "")
                                .font(.callout)
                        }
                        .frame(alignment: .leading)
                        
                    }
                    Button("Показать информацию") {
                        isMoreInfoPopupOpened = true
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }.modifier(FormElevateOnWhiteBackground())
                
                
                Section {
                    NavigationLink(destination: FriendsList(refresh: refresh, debug: $debug, isMainViewUpdated: $isMainViewUpdated, profileHeader: "", userIDtoGet: $userIDtoGet, friends: $friends, imageURL: $imageURL, viewerShown: $viewerShown)) {
                        HStack {
                            Text("Друзья")
                            Spacer()
                            if counts["friends"] == "" {ProgressView()}
                            Text(counts["friends"] ?? "error")
                                .foregroundStyle(.secondary)
                        }
                    }
                    NavigationLink(destination: About()) {
                        HStack {
                            Text("Подписчики")
                            Spacer()
                            if counts["followers"] == "" {ProgressView()}
                            Text(counts["followers"] ?? "error")
                                .foregroundStyle(.secondary)
                        }
                    }
                    if counts["groups"] != "error" {
                        NavigationLink(destination: About()) {
                            HStack {
                                Text("Группы")
                                Spacer()
                                if counts["groups"] == "" {ProgressView()}
                                Text(counts["groups"] ?? "error")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    if counts["albums"] != "error" {
                        NavigationLink(destination: About()) {
                            HStack {
                                Text("Альбомы")
                                Spacer()
                                if counts["albums"] == "" {ProgressView()}
                                Text(counts["albums"] ?? "error")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }.modifier(FormElevateOnWhiteBackground())
                
                Section {
                    Button("Новая запись") {
                        showSheet = true
                    }
                    .sheet(isPresented: $showSheet) {
                        VStack(alignment: .leading, spacing: 0.0) {
                                    Text("Введите текст:")
                                        .font(.headline)

                                    TextEditor(text: $postText)
                                        

                                    Button("Отправить") {
                                        newPost(text: postText)
                                    }
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                                .padding()
                    }
                    
                }
                .modifier(FormElevateOnWhiteBackground())
                
                
                
                Section {
                    ForEach(0..<posts.count, id:\.self) {index in
                        
                        Post(
                            post: posts[index] as! Dictionary<String, Any>,
                            profiles: postsProfiles as! [Dictionary<String, Any>],
                            imageURL: $imageURL,
                            viewerShown: $viewerShown
                        )
                        .id(UUID().uuidString) // Говно-костыль
                        .listRowInsets(EdgeInsets())
                    }
                    if !postsLoadingFinished && posts.count > 0 {
                        HStack(spacing: 10) {
                            ProgressView()
                            Text("Загрузка...")
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onAppear {
                            postsOffset+=5
                            CallAPI(function: "Wall.get", params: ["owner_id": userIDtoGet, "extended": "1", "count": "5", "offset": String(postsOffset)], completion: afterAdditionalPostsGetLoad)
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .sheet(isPresented: $isMoreInfoPopupOpened, content: {
                    NavigationView {
                        UserInfoPopup(profileObject: $profileObject)
                            .navigationTitle("Информация")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    .navigationViewStyle(.stack)
                })
            }
            else {
                if debug {
                    Section {
                        TextField("ID", text: $userIDtoGet)
                        Button ("Получить") {
                            loadEnded = false
                            loadProfileData()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    } header: {
                        Text("Получить профиль другого пользователя")
                    }
                }
                Text("Произошла ошибка загрузки профиля: \(errorReason)")
                Button("Повторить попытку") {
                    loadProfileData()
                }
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .modifier(FormHiddenBackground())
        .navigationTitle(name)
        .refreshable {
            refresh()
        }
        .onAppear(perform: loadProfileData)
    }
}

#Preview {
    MainView()
}
