//
//  User.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/15.
//

import Foundation

typealias Users = [User]

class User {
    internal init(avatar: String, userName: String) {
        self.avatar = avatar
        self.userName = userName
    }
    let avatar: String
    let userName: String
}
