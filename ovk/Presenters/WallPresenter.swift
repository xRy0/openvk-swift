//
//  WallPresenter.swift
//  OpenVK Swift
//
//  Created by Ry0 on 19.06.2025.
//

import Foundation

class WallPresenter: ObservableObject {
    
    @Published var wall: Wall?
    
    @Published var ownerId: Int
    
    let client = OVKClient()
    
    init(ownerId: Int) {
        self.ownerId = ownerId
        client.request(.wallGet(ownerId: ownerId, extended: 1, count: 5)) { (result: Result<Wall, APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let wall):
                    self.wall = wall
                case .failure(let error):
                    print("Ошибка API \(error.error_code): \(error.error_msg)")
                }
            }
        }
    }
}
