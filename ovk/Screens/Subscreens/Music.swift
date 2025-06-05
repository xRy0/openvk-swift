//
//  Music.swift
//  OpenVK Swift
//
//  Created by Ry0 on 20.01.2025.
//

import SwiftUI

struct Music: View {
    var body: some View {
        Form {
            TextField("Название", text: .constant(""))
            
        }
        .frame(height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
        NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label Content@*/Text("Navigate")/*@END_MENU_TOKEN@*/
        }
        List {
            HStack {
                AsyncImage(url: URL(string: "https://res.cloudinary.com/zenbusiness/image/upload/v1670445040/logaster/logaster-2021-02-do-you-feel-o.k-picturesque-1024x1024.jpg")){ result in
                    result.image?
                    .resizable()
                    
                }
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Song name")
                        .font(.headline)
                    Text("author")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        
                }
                Spacer()
                Text("3:42")
                    .foregroundColor(Color.gray)
            }
            HStack {
                AsyncImage(url: URL(string: "https://res.cloudinary.com/zenbusiness/image/upload/v1670445040/logaster/logaster-2021-02-do-you-feel-o.k-picturesque-1024x1024.jpg")){ result in
                    result.image?
                    .resizable()
                    
                }
                    .frame(width: 50.0, height: 50.0)
                VStack(alignment: .leading) {
                    Text("Song name")
                        .font(.headline)
                    Text("author")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        
                }
                Spacer()
                Text("3:42")
                    .foregroundColor(Color.gray)
            }
            HStack {
                AsyncImage(url: URL(string: "https://res.cloudinary.com/zenbusiness/image/upload/v1670445040/logaster/logaster-2021-02-do-you-feel-o.k-picturesque-1024x1024.jpg")){ result in
                    result.image?
                    .resizable()
                    
                }
                    .frame(width: 50.0, height: 50.0)
                VStack(alignment: .leading) {
                    Text("Song name")
                        .font(.headline)
                    Text("author")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        
                }
                Spacer()
                Text("3:42")
                    .foregroundColor(Color.gray)
            }
        }
    }
}

#Preview {
    Music()
}
