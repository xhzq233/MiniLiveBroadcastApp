//
//  PublicBoardView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/14.
//

import SwiftUI

struct PublicBoardView: View {

    init(model: PublicBoardViewModel, textFieldModel: AutoFitTextFieldViewModel) {
        self.textFieldModel = textFieldModel
        self.model = model
        self.model.delegate = giftsViewModel
    }

    @ObservedObject var model: PublicBoardViewModel
    let textFieldModel: AutoFitTextFieldViewModel

    @ObservedObject var giftsViewModel: GiftsViewModel = GiftsViewModel()
    @ObservedObject var thumbsUpViewModel: ThumbsUpViewModel = ThumbsUpViewModel()

    var body: some View {
        ZStack {
            VideoPlayerView(videoManager: model.videoManager)
                .ifAndOnlyIfOneTap { _ in
                    withAnimation {
                        model.updatePlayerState()
                    }
                } onMoreTap: { _ in
                    withAnimation {
                        thumbsUpViewModel.makeAThumbsUp()
                    }
                }
                .overlay(
                    Image(systemName: "play.fill")
                        .font(.system(size: .iconSize))
                        .opacity(model.videoManager.isPlaying ? 0 : 0.5) //animatable
                        .scaleEffect(model.videoManager.isPlaying ? 1 : 3)
                )
            VStack {
                HStack {
                    GiftsBoxView(giftsViewModel)
                        .position(x: .screenWidth / 3.5, y: .screenHeight / 1.3)
                    ThumbsUpView(viewModel: thumbsUpViewModel)
                        .position(x: .screenWidth / 2 - 40, y: .screenHeight / 2)
                }
                HStack(spacing: .horizontalSpacing) {
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
        Image(systemName: "gift")
            .foregroundColor(.pink)
            .onTapGesture {
                withAnimation {
                    giftsViewModel.sendAGift()
                }
            }
            .thinBlurBackground(shapeStyle: .thinMaterial)
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
