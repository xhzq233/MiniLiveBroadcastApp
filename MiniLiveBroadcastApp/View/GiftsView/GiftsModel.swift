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
    
    struct Gift: Identifiable {
        var content: GiftContent
        var sender: User = User()
        var count: Int = 1
        var id: Int
    }
}

struct User {
    
}
