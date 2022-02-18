//
//  GiftsViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/14.
//

import SwiftUI

//class GiftsViewModel: ObservableObject {
//    typealias Gift = GiftsModel<String>.Gift
//
//    private(set) var appearedGiftCounts: Int = 0
//
//    private static let MAX_GIFT_COUNT: Int = 2
//
//    static let giftEmojis = ["🎁", "🎁", "🎁", "🎁", "🎁", "🎁", "🎁"]
//
//    static func createGiftsModel() -> GiftsModel<String> {
//        GiftsModel<String>(numberOfGifts: 0) { index in
//            GiftsViewModel.giftEmojis[index]
//        }
//    }
//
//    @Published var giftsModel = createGiftsModel()
//
//    var gifts: [Gift] {
//        giftsModel.gifts
//    }
//
//    // MARK: Intents
//
//    func sendAGift() {
//        giftsModel.sendAGift(createGiftContent: { index in
//            return GiftsViewModel.giftEmojis[0]
//        })
//    }
//}

extension GiftsViewModel: PublicBoardViewPageChangedDelegate {
    func onPageDidChanged() {

    }

    func onPageEndDisplay() {

    }
}

class GiftsViewModel: ObservableObject {
    @Published private(set) var gifts: Gifts = []
    
    func fire(_ gift: Gift) {
        withAnimation {
            gifts.insert(gift, at: 0)
        }
        if gifts.count > Self.maxCount {
            withAnimation {
                _ = gifts.popLast()
                /// a common mistake ,
                /// if remove underbar xcode will throw a warning: returned value not used,
                /// because withAnimation did have a returned value which ur block returned
            }
        }
    }
    
    static let maxCount = 3
}
