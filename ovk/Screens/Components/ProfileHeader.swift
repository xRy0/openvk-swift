//
//  ProfileHeader.swift
//  OpenVK Swift
//
//  Created by Ry0 on 15.06.2025.
//

import SwiftUI

struct ProfileHeader: View {
    @ObservedObject var presenter: ProfilePresenter
    @State var additionalInfoSheetShow = false
    
    var body: some View {
        HStack (alignment: .top, spacing: 20) {
            AsyncImage(url: URL(string: presenter.profile?.photo200 ?? (getValueFromUserDefaults(forKey: "instance") ?? "https://ovk.to") + "/assets/packages/static/openvk/img/camera_200.png")) { image in image.resizable().scaledToFill() }
            placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            VStack (alignment: .leading) {
                HStack {
                    Text("\(presenter.profile?.firstName ?? "") \(presenter.profile?.lastName ?? "")")
                        .font(.headline)
                    if (presenter.profile?.verified != 0) {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(.blue)
                    }
                }
                Text(presenter.lastSeen)
                    .font(.subheadline)
                    .foregroundColor((presenter.profile?.online != 0) ? .primary : .secondary)
                Spacer()
                    .frame(height: 15)
                Text(presenter.profile?.status ?? "")
                    .font(.callout)
            }
            .frame(alignment: .leading)
        }
        Button ("Подробнее") {
            additionalInfoSheetShow = true
        }
        .sheet(isPresented: $additionalInfoSheetShow, content: {
            ProfileInfoSheet(presenter: presenter)
        })
    }
}

#Preview {
    MainView()
}
