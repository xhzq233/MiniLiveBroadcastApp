//
//  ThumbsUpView.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/13.
//

import SwiftUI

struct ThumbsUpView: View {
    
    @ObservedObject var viewModel: ThumbsUpViewModel
    
    var body: some View{
        VStack {
            let thumb = viewModel.thumbsUp
            Image(systemName: thumb.content)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: Double(Int.random(in: -60 ... -30))))
                .scaleEffect(thumb.isAlive ? 2:0)
                .opacity(thumb.isAlive ? 0.6:0)
//                .onAppear {
//                    withAnimation{
//                        thumb.isAlive = true
//                    }
//
//                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
//                        withAnimation {
//                            thumb.isAlive = false
//                        }
//                    })
//                }
        }
        .onTapGesture {
            viewModel.makeAThumbsUp()
        }
    }
    
}

struct ThumbsUpView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbsUpView(viewModel: ThumbsUpViewModel())
    }
}
