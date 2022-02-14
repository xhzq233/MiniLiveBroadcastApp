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
            ForEach(giftsViewModel.gifts) { gift in
                GiftView(gift)
                    .frame(width: 200, height: 60, alignment: .trailing)
                    .opacity(0.3)

            }
        }
        
//        VStack {
//            ForEach(giftsViewModel.gifts) { gift in
//                GiftView(gift)
//                    .frame(width: 200, height: 60, alignment: .trailing)
//                    .opacity(0.3)
//            }
//        }
        
    }
}

struct GiftView: View {
    private let gift: GiftsViewModel.Gift
    
    init(_ gift: GiftsViewModel.Gift) {
        self.gift = gift
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            }
        })
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
