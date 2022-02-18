//
//  GiftsViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/14.
//

import SwiftUI

extension GiftsViewModel: PublicBoardViewPageChangedDelegate {
    func onPageDidChanged() {
        gifts.removeAll()
    }

    func onPageEndDisplay() {
        //nothing to do...
    }
}

class GiftsViewModel: ObservableObject {
    @Published private(set) var gifts: Gifts = []

    func fire(_ gift: Gift) {

        //  a difference between gift and bullet is gift have multi hit
        // if the same person fired the same gift again, just add hit count
        // that's why use UserName and gift id as identifier
        if let index = gifts.firstIndex(where: { $0.id == gift.id }) {
            gifts[index].count += 1
        } else {
            withAnimation {
                gifts.insert(gift.copy, at: 0)
            }
        }
        if gifts.count > Self.maxCount {
            withAnimation {
                _ = gifts.popLast()
                /// a common mistake ,
                /// if remove underbar XCode will throw a warning: returned value not used,
                /// because withAnimation did have a returned value which ur block returned
            }
        }
    }

    init() {
        //auto remove
        Timer.scheduledTimer(withTimeInterval: Self.autoRemoveRefreshTime, repeats: true) {
            [weak self] timer in
            if let self = self {
                if self.gifts.isEmpty { return }

                //remove gifts which are not active
                let gifts = self.gifts.filter({ $0.isActive })
                if gifts.count != self.gifts.count {
                    withAnimation {
                        self.gifts = gifts
                    }
                }
            } else {
                timer.invalidate()
            }
        }
    }

    //MARK: Constant
    static let maxCount = 3
    static let autoRemoveRefreshTime = 0.3
}
