//
//  GiftsModel.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/14.
//

import Foundation

struct GiftsModel<GiftContent> where GiftContent: Equatable {
    private(set) var gifts: [Gift]
    
    init(numberOfGifts: Int, createGiftContent: (Int) -> GiftContent) {
        gifts = []
        for index in 0..<numberOfGifts {
            let content = createGiftContent(index)
            gifts.append(Gift(content:content, id: index))
        }
    }
    
    // 发送礼物
    mutating func sendAGift(createGiftContent: (Int) -> GiftContent) {
        let content = createGiftContent(gifts.count)
        gifts.append(Gift(isAlive: isTheFirstTwoGifts(gifts.count), content: content, id: gifts.count))
        print(gifts.count)
    }
    
    mutating func isTheFirstTwoGifts(_ count: Int) -> Bool {
        if count >= 2 {
            return false
        }
        return true
    }
    
    struct Gift: Identifiable {
        var isAlive: Bool = false
        var content: GiftContent
        var sender: User = User()
        var count: Int = 1
        var id: Int
    }
}

struct User {
    
}
