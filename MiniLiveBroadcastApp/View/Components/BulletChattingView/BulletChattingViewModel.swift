//
//  BulletChattingViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/18.
//

import SwiftUI

class BulletChattingViewModel: ObservableObject {
    @Published var bullets: Bullets = []

    func fire(_ bullet: Bullet) {
        withAnimation {
            bullets.insert(bullet, at: 0)
        }
        if bullets.count > Self.maxCount {
            withAnimation {
                _ = bullets.popLast()
                /// a common mistake ,
                /// if remove underbar xcode will throw a warning: returned value not used,
                /// because withAnimation did have a returned value which ur block returned
            }
        }
    }
    
    static let maxCount = 5
}
