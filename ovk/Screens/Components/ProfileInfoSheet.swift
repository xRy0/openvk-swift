//
//  profileInfoSheet.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import SwiftUI

struct ProfileInfoSheet: View {
    @ObservedObject var presenter: ProfilePresenter
    
    var body: some View {
        Form {
            ForEach(presenter.profileAdditionalInfo(from: presenter.profile!), id: \.category) { category in
                let nonEmptyValues = category.value.filter { !$0.value.isEmpty }
                        
                if !nonEmptyValues.isEmpty {
                    Section (category.category) {
                        ForEach(category.value, id: \.title) { info in
                            if info.value != "" {
                                VStack (alignment: .leading) {
                                    Text(info.title)
                                        .font(.callout.smallCaps())
                                        .foregroundStyle(.secondary)
                                    Text(info.value)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
