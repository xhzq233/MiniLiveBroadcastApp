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
            Image(systemName: viewModel.thumbsUp.content)
                .resizable()
                .frame(width: 30, height: 30)
                .rotationEffect(Angle.degrees(viewModel.thumbsUp.isAlive ? 360: 0))
                .foregroundColor(viewModel.thumbsUp.isAlive ? .red.opacity(0.7) : .black.opacity(0.8))
        }
        .onTapGesture {
            withAnimation {
                viewModel.changeAlive()
            }
        }
    }
    
}

struct ThumbsUpView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbsUpView(viewModel: ThumbsUpViewModel())
    }
}
