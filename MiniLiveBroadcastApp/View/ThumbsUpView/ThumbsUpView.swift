//
//  ThumbsUpView.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/13.
//

import SwiftUI

struct ThumbsUpView: View {
    
    @ObservedObject var viewModel: ThumbsUpViewModel
    
    var body: some View {
        VStack {
            Thumb(thumbsUp: viewModel.thumbsUp)
        }
        .onTapGesture {
            withAnimation {
                viewModel.changeAlive()
            }
        }
    }
    
}

struct Thumb: View {
    
    var thumbsUp: ThumbsUpViewModel.ThumbsUp
    
    var body: some View {
        Image(systemName: thumbsUp.content)
            .resizable()
            .frame(width: 30, height: 30)
            .rotationEffect(Angle.degrees(thumbsUp.isAlive ? 360: 0))
            .foregroundColor(thumbsUp.isAlive ? .red.opacity(0.7) : .black.opacity(0.8))
    }
}

struct ThumbsUpView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbsUpView(viewModel: ThumbsUpViewModel())
    }
}
