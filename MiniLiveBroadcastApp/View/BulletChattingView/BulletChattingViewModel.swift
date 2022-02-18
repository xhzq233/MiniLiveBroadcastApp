//
//  BulletChattingViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/18.
//

import SwiftUI

class BulletChattingViewModel: ObservableObject {
    @Published private(set) var bullets: Bullets = []
    
    func fire(_ bullet: Bullet) {
        withAnimation {
            bullets.insert(bullet, at: 0)
        }
        if bullets.count > Self.maxCount {
            withAnimation {
                _ = bullets.popLast()
            }
        }
    }
    static let maxCount = 5
}
