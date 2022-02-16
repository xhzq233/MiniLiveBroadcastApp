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
    
    struct ThumbsUp {
        var isAlive: Bool = true
        var content: String = "hand.thumbsup"
        var id: Int = 0
    }
    
}
