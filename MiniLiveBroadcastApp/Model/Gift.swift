//
//  Gift.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/18.
//

import Foundation

typealias Gifts = [Gift]

class Gift: Identifiable {
    internal init(sender: User, giftID: Int) {
        self.sender = sender
        self.giftID = giftID
    }
    //use gift id and sender name as Identifier
    var id: [UInt8] {
        giftID.byteArray + [UInt8](sender.userName.utf8)
    }
    let sender: User
    let giftID: Int
    var count: Int = 1

    /// phase id to the gift image url
    var giftURL: String {
        //TODO: giftID
        ScrollPageCellConfigure.bilibiliPersonAvatar  // temporary
    }
}
