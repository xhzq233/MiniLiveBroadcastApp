//
//  PublicBoardView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/14.
//

import SwiftUI

struct PublicBoardView: View {
    
    @ObservedObject var model:PublicBoardViewModel
    let textFieldModel:AutoFitTextFieldViewModel
    @ObservedObject var giftsViewModel: GiftsViewModel = GiftsViewModel()
    
    var body: some View {
        ZStack {
            VideoPlayerView(videoManager: model.videoManager)
                .onTapGesture(count: 1) {
                    model.videoManager.updatePlayerState()
                }
                .simultaneousGesture(
                    TapGesture(count: 2).onEnded() {
                        print("你给这个视频点了个赞，并且在这里创建并删除一个带动画的点赞动效")
                    }
                )
            VStack {
                Spacer(minLength: 0)
                GiftsBoxView(giftsViewModel)
                    .position(x: .screenWidth / 3.5, y: .screenHeight / 1.3)
                HStack {
                    ZStack {
                        AutoFitTextFieldView(model: textFieldModel)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: .screenWidth / 1.2)
                    }
                    sendGiftsButton
                }
                ProgressView(value: model.progress)
                    .padding(.bottomPadding)
            }
            .opacity(model.isVideoReady ? 1 : 0)
        }
        .alert(isPresented: $model.isVideoLoadFailed){
            Alert(title: Text("Video Load Failed"),
                  message: Text(model.errorDescription),
                  dismissButton: .default(Text("Ok")))
        }
        .ignoresSafeArea()
    }
    
    
    var sendGiftsButton: some View {
        ZStack {
            Button(action: {
                withAnimation {
                    giftsViewModel.sendAGift()
                }
            }) {
                Image(systemName: "gift").foregroundColor(.pink)
            }
            .frame(width: DrawingConstants.bottomAreaHeight ,height: DrawingConstants.bottomAreaHeight)
            .background(.white.opacity(0.3))
            .cornerRadius(5)
    }
}

fileprivate struct DrawingConstants {
    static let bottomAreaHeight: CGFloat = 35
}

struct PublicBoardView_Previews: PreviewProvider {
    static var previews: some View {
        PublicBoardView(
            model: PublicBoardViewModel(),
            textFieldModel: AutoFitTextFieldViewModel(),
            giftsViewModel: GiftsViewModel())
    }
}
