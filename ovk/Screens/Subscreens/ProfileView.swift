//
//  Profile.swift
//  OpenVK Swift
//
//  Created by Ry0 on 16.06.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var presenter = ProfilePresenter()
    
    var body: some View {
        Form {
            ProfileHeader(presenter: presenter)
            if let counters = presenter.profile?.counters {
                Section {
                    ForEach(presenter.profileStats(from: counters), id: \.title) { stat in
                        NavigationLink(destination: About()) {
                            HStack {
                                Text(stat.title)
                                Spacer()
                                Text("\(stat.value)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            if presenter.profile?.uid != nil {
                WallComponent(ownerId: (presenter.profile?.uid!)!)
            }
        }
        .refreshable {
            presenter.getMe()
        }
    }
}

#Preview {
    MainView()
}
