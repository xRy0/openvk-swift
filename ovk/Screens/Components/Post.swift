//
//  Post.swift
//  OpenVK Swift
//
//  Created by Isami Riša on 10.11.2023.
//

import SwiftUI

struct Post: View {
    
    @State var post: WallPosts
    @State var profiles: [PostsProfiles]
    @State var groups: [GroupModel] = []

    @State var userProfile: PostsProfiles?
    @State var groupProfile: GroupModel?

    @State var attachments: [[String: Any]] = []

    func loadData() {
        attachments = post.attachments as? [[String: Any]] ?? []
        let fromId = post.fromId ?? -1
        if fromId < 0 {
            groupProfile = groups.first { $0.id == abs(fromId) }
        } else {
            userProfile = profiles.first { $0.id == fromId }
        }
    }

    func getImageURL(post: WallPosts, size: Int = 0, imageIndex: Int = 0) -> String {
        guard let attachments = post.attachments as? [[String: Any]],
              attachments.indices.contains(imageIndex),
              let photoObject = attachments[imageIndex]["photo"] as? [String: Any],
              let sizes = photoObject["sizes"] as? [[String: Any]],
              sizes.indices.contains(size),
              let url = sizes[size]["url"] as? String else {
            return ""
        }
        return url
    }

    func getUserOrGroupName() -> String {
        if let group = groupProfile {
            return group.name ?? "Ошибка"
        } else if let user = userProfile {
            return "\(user.firstName ?? "") \(user.lastName ?? "")"
        }
        return "Ошибка"
    }

    var body: some View {
        Group {
            VStack(alignment: .leading) {
                // Аватарка, имя и дата
                HStack(spacing: 15) {
                    AsyncImage(url: URL(string: groupProfile?.photo50 ?? userProfile?.photo50 ?? "")) {
                        image in image.resizable().scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(getUserOrGroupName())
                            .font(.headline)
                            .lineLimit(1)
                        Text(convertTimestampToPostTime(timestamp: post.date ?? 0))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .imageScale(.large)
                            .padding(5)
                    }
                    .foregroundColor(.secondary)
                }

                Spacer().frame(height: 10)

                // Текст поста
                if let text = post.text, !text.isEmpty {
                    Text(text)
                }

                // Одиночная фотография
                if (attachments.first?["type"] as? String) == "photo" &&
                    (attachments.count < 2 ||
                     (attachments.indices.contains(1) && (attachments[1]["type"] as? String) != "photo")) {

                    Button(action: {
                        // imageURL = getImageURL(post: post, size: 10)
                        // viewerShown = true
                    }) {
                        AsyncImage(url: URL(string: getImageURL(post: post, size: 10))) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            AsyncImage(url: URL(string: getImageURL(post: post))) { image in
                                image.resizable().scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }.cornerRadius(10)
                        }.cornerRadius(10)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }

                // Множественные фотографии
                if attachments.indices.contains(1), attachments[1]["type"] as? String == "photo" {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3)) {
                        ForEach(attachments.indices, id: \.self) { index in
                            if attachments[index]["type"] as? String == "photo" {
                                Button(action: {
                                    print("Бутон нажат с индексом \(index)")
                                    // imageURL = getImageURL(post: post, size: 10, imageIndex: index)
                                    // viewerShown = true
                                }) {
                                    AsyncImage(url: URL(string: getImageURL(post: post, size: 10, imageIndex: index))) { image in
                                        image.resizable().scaledToFill().frame(width: 100, height: 100)
                                    } placeholder: {
                                        AsyncImage(url: URL(string: getImageURL(post: post, size: 0, imageIndex: index))) { image in
                                            image.resizable().scaledToFill().frame(width: 100, height: 100)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .cornerRadius(10)
                                        .frame(width: 100, height: 100)
                                    }
                                    .cornerRadius(10)
                                    .frame(width: 100, height: 100)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                }
            
        
    
                /*
                // Опросы
                ForEach(0..<attachments.count, id:\.self) {index in
                    if (attachments.indices.contains(index)) {
                        if (attachments[index]["type"] as? String) == "video" {
                            if post.text != "" {
                                Spacer()
                            }
                            Text("Прикреплено видео: \((attachments[index]["video"] as? [String:Any])?["title"] as? String ?? "Без названия")")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // Опросы
                ForEach(0..<attachments.count, id:\.self) {index in
                    if (attachments.indices.contains(index)) {
                        if (attachments[index]["type"] as? String) == "poll" {
                            if post["text"] as! String != "" {
                                Spacer()
                            }
                            Text("Прикреплён опрос: \((attachments[index]["poll"] as? [String:Any])?["question"] as? String ?? "Неизвестный")")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // Аудиозаписи
                ForEach(0..<attachments.count, id:\.self) {index in
                    if (attachments.indices.contains(index)) {
                        if (attachments[index]["type"] as? String) == "audio" {
                            if post["text"] as! String != "" {
                                Spacer()
                            }
                            Text("Прикреплено аудио: \((attachments[index]["audio"] as? [String:Any])?["title"] as? String ?? "Без названия") - \((attachments[index]["audio"] as? [String:Any])?["artist"] as? String ?? "Неизвестен")")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                    }
                }*/
                
                // Кнопки снизу поста
                Spacer()
                    .frame(height: 10)
                
                HStack {
                    Button (action: {}) {
                        Image(systemName: "arrowshape.turn.up.forward")
                            .imageScale(.large)
                            .padding(5)
                    }
                    .foregroundColor(.secondary)
                    
                    Spacer()
                    Button (action: {}) {
                        HStack (spacing: 2) {
                            Image(systemName: "bubble")
                                .imageScale(.large)
                                .padding(5)
                            Text("1")
                        }
                    }
                    .foregroundColor(.secondary)
                    
                    Button (action: {}) {
                        HStack (spacing: 2) {
                            Image(systemName: "heart")
                                .imageScale(.large)
                                .padding(5)
                            Text("1")
                        }
                    }
                    .foregroundColor(.secondary)
                }
            }
            
            
            .padding([.top, .bottom], 10)
        }.onAppear(perform: loadData)
    }
}

#Preview {
    MainView()
}
