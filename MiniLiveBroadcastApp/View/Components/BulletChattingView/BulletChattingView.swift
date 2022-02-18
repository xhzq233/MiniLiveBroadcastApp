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
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(model.bullets) {
                    BulletChatRow(bullet: $0)
                        .lineLimit(nil)
                        .scaleEffect(x: 1, y: -1, anchor: .center)
                        .transition(
                            .asymmetric(
                                insertion: .opacity.combined(with: .slide),
                                removal: .opacity.combined(with: .move(edge: .bottom))
                            )
                        )
                    //asymmetric transition
                }
            }
        }
        //disable scroll
        .allowsHitTesting(false)
        .frame(height: .screenHeight / 4)
        .scaleEffect(x: 1, y: -1, anchor: .center)  // trick to reverse list
        .onAppear {
            //remove all when page changed
            model.bullets.removeAll()
        }
    }
}

struct BulletChatRow: View {
    let bullet: Bullet
    var body: some View {  //swiftUI support native rich text
        (Text(bullet.prefix)
            + Text(" " + bullet.sender.userName + ": ").bold()
            .foregroundColor([.pink, .green, .blue].randomElement()!)
            + Text(bullet.content))
            .frame(height: Self.rowHeight, alignment: .leading)
            .padding(2)
            .background(.thinMaterial, in: Capsule())
            .padding(1)
    }

    static let rowHeight = 28.0
}
