//
//  PublicBoardView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/14.
//

import SwiftUI

struct PublicBoardView: View {
    
    init(model: PublicBoardViewModel,textFieldModel: AutoFitTextFieldViewModel) {
        self.textFieldModel = textFieldModel
        self.model = model
        self.model.delegate = giftsViewModel
    }
    
    @ObservedObject var model: PublicBoardViewModel
    let textFieldModel: AutoFitTextFieldViewModel
    @State var isVideoPlaying = false
    @ObservedObject var giftsViewModel: GiftsViewModel = GiftsViewModel()
    @ObservedObject var thumbsUpViewModel: ThumbsUpViewModel = ThumbsUpViewModel()

    var body: some View {
        ZStack {
            VideoPlayerView(videoManager: model.videoManager)
                .onTapGesture(count: 1) {
                    model.videoManager.updatePlayerState()
                }
                .simultaneousGesture(
                    TapGesture(count: 2).onEnded {
                        withAnimation {
                            thumbsUpViewModel.makeAThumbsUp()
                        }
                    }
                )
            VStack {
                HStack {
                    GiftsBoxView(giftsViewModel)
                        .position(x: .screenWidth / 3.5, y: .screenHeight / 1.3)
                    ThumbsUpView(viewModel: thumbsUpViewModel)
                        .position(x: .screenWidth / 2 - 40, y: .screenHeight / 2)
                }
                HStack {
                    ZStack {
                        AutoFitTextFieldView(model: textFieldModel)
                            .frame(width: .screenWidth / 1.2)
                    }
                    sendGiftsButton
                }
                ProgressView(value: model.progress)
                    .padding(.bottomPadding)
            }
        }
        .opacity(model.isVideoReady ? 1 : 0)
        .alert(isPresented: $model.isVideoLoadFailed) {
            Alert(
                title: Text("Video Load Failed"),
                message: Text(model.errorDescription),
                dismissButton: .default(Text("Ok")))
        }
        .ignoresSafeArea()

    }

    var sendGiftsButton: some View {
        Button(action: {
            withAnimation {
                giftsViewModel.sendAGift()
            }
        }) {
            Image(systemName: "gift").foregroundColor(.pink)
        }
        .frame(width: DrawingConstants.bottomAreaHeight, height: DrawingConstants.bottomAreaHeight)
        .background(.white.opacity(0.3))
        .cornerRadius(5)
    }
}

private struct DrawingConstants {
    static let bottomAreaHeight: CGFloat = 35
}

struct PublicBoardView_Previews: PreviewProvider {
    static var previews: some View {
        PublicBoardView(
            model: PublicBoardViewModel(),
            textFieldModel: AutoFitTextFieldViewModel())
    }
}
