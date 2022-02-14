//
//  GiftsViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/14.
//

import Foundation
import UIKit

class GiftsViewModel: ObservableObject {
    typealias Gift = GiftsModel<String>.Gift
    
    static let giftEmojis = ["🤣", "🤣", "🤣", "🤣", "🤣"]
    
    static func createGiftsModel() -> GiftsModel<String> {
        GiftsModel<String>(numberOfGifts: 2) { index in
            GiftsViewModel.giftEmojis[index]
        }
    }
    
    @Published var giftsModel = createGiftsModel()
    
    var gifts: [Gift] {
        giftsModel.gifts
    }
    
    // MARK: Intents
    
    
    
}
