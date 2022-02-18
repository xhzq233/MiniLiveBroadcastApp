//
//  Gift.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/18.
//

import Foundation

typealias Gifts = [Gift]

struct Gift: Identifiable {
    internal init(sender: User, giftID: Int, count: Int = 1) {
        self.sender = sender
        self.giftID = giftID
        self.count = count
    }

    //use gift id and sender name as Identifier
    var id: [UInt8] {
        giftID.byteArray + [UInt8](sender.userName.utf8)
    }
    let sender: User
    let giftID: Int
    var count: Int {
        didSet {
            refreshTime()
        }
    }

    /// phase id to the gift image url
    var giftURL: String {
        Self.id2url[giftID] ?? ScrollPageCellConfigure.bilibiliPersonAvatar
    }
    
    static let id2url:[Int:String] = {
        var dict:[Int:String] = [:]
        for (index,str) in ScrollPageCellConfigure.avatars.enumerated(){
            dict[index] = str
        }
        return dict
    }()

    //MARK: time remaining

    // how long a gift can active in view
    static let timeActive: TimeInterval = 8

    var isActive: Bool {
        //if
        if let lastFaceUpDate = self.lastHitTime {
            return Date().timeIntervalSince(lastFaceUpDate) < Self.timeActive
        } else {
            return true
        }
    }
    // the last time this card was turned up (and is still face up)
    private var lastHitTime: Date?

    // called when the gift have been hit again
    private mutating func refreshTime() {
        lastHitTime = Date()
    }

    /// copied item
    ///
    /// in case have been refreshedTime when initialize
    var copy: Self {
        var gift = Gift(sender: sender, giftID: giftID, count: count)
        gift.refreshTime()
        return gift
    }
}
