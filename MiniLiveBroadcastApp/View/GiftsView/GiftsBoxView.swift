//
//  GiftsBoxView.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/14.
//

import SwiftUI

struct GiftsBoxView: View {
    @ObservedObject var giftsViewModel: GiftsViewModel
    
    var body: some View {
        LazyVStack(alignment: .center, spacing: 5, pinnedViews: .sectionFooters) {
            
            // TODO: 临时Button
            Button("send a gift") {
                withAnimation {
                    giftsViewModel.sendAGift()
                }
            }
            
            ForEach(giftsViewModel.gifts) { gift in
                if gift.isAlive {
                    GiftView(gift)
                        .frame(width: 200, height: 60, alignment: .center)
                        .transition(AnyTransition.opacity.combined(with: .slide))
                }
            }
        }
        .frame(width: 200 + 10, height: 60*2 + 10, alignment: .center)
    }
}

struct GiftView: View {
    private let gift: GiftsViewModel.Gift
    
    init(_ gift: GiftsViewModel.Gift) {
        self.gift = gift
    }
    
    // TODO: 读取礼物发送者的信息放入View中
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    .opacity(0.3)
                HStack {
                    Image(gift.sender.profilePicture)
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().strokeBorder(.red ,lineWidth: 5))
                        .frame(width: 60, height: 60, alignment: .center)
                    VStack {
                        Text(/* gift.sender.userName */ String(gift.id))
                            .lineLimit(1)
                            
                    }
                    .frame(width: 200 - 60*2 - 15 , height: 60, alignment: .center)
                    Text(gift.content)
                        .frame(width: 60, height: 60, alignment: .center)
                }
            }
            .transition(AnyTransition.opacity.combined(with: .slide))
        }
        
    }
}

fileprivate struct DrawingConstants {
    static let cornerRadius: CGFloat = 40
}


struct GiftsView_Previews: PreviewProvider {
    static var previews: some View {
        let giftsViewModel = GiftsViewModel()
        GiftsBoxView(giftsViewModel: giftsViewModel)
    }
}
