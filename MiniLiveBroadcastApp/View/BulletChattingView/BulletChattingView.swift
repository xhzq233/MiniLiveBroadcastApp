//
//  BulletChattingView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/18.
//

import SwiftUI

struct BulletChattingView: View {

    @ObservedObject var model: BulletChattingViewModel

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(model.bullets) {
                BulletChatRow(bullet: $0)
                    .lineLimit(3)
                    .scaleEffect(x: 1, y: -1, anchor: .center)
                    .transition(.opacity.combined(with: .slide))
            }
            HStack {
                Spacer()
            }
            .hidden()  //used to expand horizontal space
        }
        .scaleEffect(x: 1, y: -1, anchor: .center)  // trick to reverse list
    }
}

struct BulletChatRow: View {
    let bullet: Bullet
    var body: some View {  //swiftUI support native rich text
        (Text(bullet.prefix)
            .font(.title)
            + Text(bullet.name + ":").bold().foregroundColor(.green)
            + Text(bullet.content))
            .thinBlurBackground()
    }
}

