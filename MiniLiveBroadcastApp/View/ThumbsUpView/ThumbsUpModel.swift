//
//  ThumbsUpModel.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/15.
//

import Foundation

struct ThumbsUpModel {
    
    private(set) var thumbsUp = ThumbsUp()
    
    private(set) var hit: (x: Double, y: Double) = (0, 0)
    
    mutating func makeAThumbsUp(x: Double, y: Double) {
        thumbsUp.isAlive = true
        self.hit.x = x
        self.hit.y = y
    }
    
    mutating func changeAlive() {
        thumbsUp.isAlive.toggle()
    }
    
    struct ThumbsUp {
        var isAlive: Bool = false
        var content: String = "hand.thumbsup.fill"
        var id: Int = 0
    }
    
}
