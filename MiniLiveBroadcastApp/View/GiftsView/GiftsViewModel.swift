//
//  GiftsViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/14.
//

import Foundation
import UIKit
import simd

class GiftsViewModel: ObservableObject {
    typealias Gift = GiftsModel<String>.Gift
    
    private(set) var appearedGiftCounts: Int = 0
    
    private static let MAX_GIFT_COUNT: Int = 2
    
    static let giftEmojis = ["🤣", "🤣", "🤣", "🤣", "🤣", "🤣", "🤣", "🤣", "🤣", "🤣"]
    
    static func createGiftsModel() -> GiftsModel<String> {
        GiftsModel<String>(numberOfGifts: 0) { index in
            GiftsViewModel.giftEmojis[index]
        }
    }
    
    @Published var giftsModel = createGiftsModel()
    
    var gifts: [Gift] {
        giftsModel.gifts
    }
    
    // MARK: Intents
    
    func sendAGift() {
        giftsModel.sendAGift(createGiftContent: { index in
                return GiftsViewModel.giftEmojis[0]
        })
    }
    
}
