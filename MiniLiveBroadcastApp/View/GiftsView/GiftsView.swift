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
        VStack(alignment: .leading) {
            ForEach(model.gifts) {
                GiftRow(gift: $0)
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

struct GiftRow: View {
    let gift: Gift
    var body: some View {
        GeometryReader { geo in
            let imageSize = geo.size.width * Self.factor
            HStack {
                HStack {
                    URLImage(urlString: gift.sender.avatar)
                        .frame(width: imageSize)
                        .clipShape(Circle())
                    Text(gift.sender.userName)
                    URLImage(urlString: gift.giftURL)
                        .frame(width: imageSize)
                        .clipShape(Circle())
                }.background(.thinMaterial, in: Capsule())
                //count view

            }
        }

    }
    static let factor = 0.5 / 3
}
