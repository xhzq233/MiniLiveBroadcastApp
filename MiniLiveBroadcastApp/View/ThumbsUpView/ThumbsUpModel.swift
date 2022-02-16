//
//  ThumbsUpModel.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/15.
//

import Foundation

struct ThumbsUpModel {
    
    private(set) var thumbsUp = ThumbsUp()
    
    mutating func makeAThumbsUp() {
        thumbsUp.isAlive = true
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
