//
//  Bullet.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/18.
//

import Foundation

typealias Bullets = [Bullet]
struct Bullet: Identifiable {
    let id = UUID()
    let prefix: String
    let name: String
    let content: String
}
