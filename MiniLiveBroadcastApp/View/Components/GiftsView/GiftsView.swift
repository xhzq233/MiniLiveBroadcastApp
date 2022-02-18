//
//  GiftsBoxView.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/14.
//

import SwiftUI

struct GiftsView: View {

    @ObservedObject var model: GiftsViewModel

    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(model.gifts) {
                GiftRow(gift: $0)
                    .scaleEffect(x: 1, y: -1, anchor: .center)
                    .transition(
                        .asymmetric(
                            insertion: .opacity.combined(with: .slide),
                            removal: .opacity.combined(with: .move(edge: .bottom))
                        )
                    )
            }
        }
        .scaleEffect(x: 1, y: -1, anchor: .center)  // trick to reverse list
    }
}

struct GiftRow: View {
    let gift: Gift
    var body: some View {
        HStack {
            HStack {
                URLImage(urlString: gift.sender.avatar)
                    .frame(width: Self.size, height: Self.size)
                    .clipShape(Circle())
                Text(gift.sender.userName)
                URLImage(urlString: gift.giftURL)
                    .frame(width: Self.size, height: Self.size)
                    .clipShape(Circle())
            }.background(.thinMaterial, in: Capsule())
            //count view
            if gift.count > 1 {
                Text("x\(gift.count)")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .transition(
                        .scale.combined(with: .opacity).combined(with: .slide).animation(.spring())
                    )
            }
        }

    }
    private static let size = 50.0
}
