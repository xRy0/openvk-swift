//
//  WallComponent.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import SwiftUI

struct WallComponent: View {
    @State var ownerId: Int
    @ObservedObject var presenter: WallPresenter
    
    init(ownerId: Int) {
        self.ownerId = ownerId
        self.presenter = WallPresenter(ownerId: ownerId)
    }
    
    var body: some View {
        Section {
            ForEach(presenter.wall?.items ?? [], id: \.pid) { post in
                Post(post: post, profiles: (presenter.wall?.profiles)!)
                        .listRowInsets(EdgeInsets())
                }
            /*ForEach(0..<(presenter.wall?.items!.count)!, id:\.self) {index in
                
                Post(
                    post: presenter.wall?.items?, // as! Dictionary<String, Any>,
                    profiles: presenter.wall?.profiles as! [Dictionary<String, Any>],
                    //imageURL: Binding<String>.constant(""), //$imageURL,
                    //viewerShown: Binding<Bool>.init(set: false) //$viewerShown
                )
                .listRowInsets(EdgeInsets())
            }*/
            /*if !postsLoadingFinished && posts.count > 0 {
                HStack(spacing: 10) {
                    ProgressView()
                    Text("Загрузка...")
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .onAppear {
                    postsOffset+=5
                    CallAPI(function: "Wall.get", params: ["owner_id": userIDtoGet, "extended": "1", "count": "5", "offset": String(postsOffset)], completion: afterAdditionalPostsGetLoad)
                }
            }*/
        }
    }
}

#Preview {
    MainView()
}
