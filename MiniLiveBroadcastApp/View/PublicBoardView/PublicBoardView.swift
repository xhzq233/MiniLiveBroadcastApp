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
        Group {
            if model.isVideoReady {  // use `if` to avoid pre load
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
                                .opacity(model.videoManager.isPlaying ? 0 : 0.7)  //animatable
                                .scaleEffect(model.videoManager.isPlaying ? 1 : 3)
                        )
                    VStack {
                        topArea
                            .padding(.top, .topPadding)
                        HStack {
                            GiftsBoxView(giftsViewModel)
                                .position(x: .screenWidth / 3.5, y: .screenHeight / 1.3)
                            ThumbsUpView(viewModel: thumbsUpViewModel)
                                .position(x: .screenWidth / 2 - 40, y: .screenHeight / 2)
                        }
                        HStack(spacing: .horizontalSpacing) {
                            ZStack(alignment: .trailing) {
                                AutoFitTextFieldView(model: textFieldModel)
                                    .padding(.leading, 4)
                                Image(systemName: "mic.fill")
                                    .imageScale(.large)
                                    .padding()
                            }
                            Image(systemName: "suit.heart.fill")
                                .foregroundColor(.pink)
                                .thinBlurBackground(shape: Circle())
                            sendGiftsButton
                        }
                        ProgressView(value: model.progress)
                            .padding(.bottomPadding)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .alert(isPresented: $model.isVideoLoadFailed) {
            Alert(
                title: Text("Video Load Failed"),
                message: Text(model.errorDescription),
                dismissButton: .default(Text("Ok"))
            )
        }

    }

    var sendGiftsButton: some View {
        Image(systemName: "gift")
            .foregroundColor(.pink)
            .onTapGesture {
                withAnimation {
                    giftsViewModel.sendAGift()
                }
            }
            .thinBlurBackground(shape: Circle())
    }

    var topArea: some View {
        GeometryReader { geo in
            let size = geo.size.width * DrawingConstants.imageSizeFactor
            HStack(spacing: .horizontalSpacing) {
                HStack {
                    URLImage(urlString: model.config.avatar)
                        .frame(width: size)
                        .clipShape(Circle())
                    Text(model.config.title)
                        .font(.caption2)
                        .lineLimit(1)
                    Text(String.Follow)
                        .font(.caption)
                        .foregroundColor(.white)
                        .frame(width: size * 1.1)
                        .lineLimit(1)
                        .padding(2)
                    //this is margin, inner view padding with container view
                        .background(.red, in: Capsule())
                        .padding(.horizontal,2)
                }
                .background(.thinMaterial, in: Capsule())
                .padding(.leading, .horizontalSpacing)

                Spacer(minLength: size * 2)
                HStack(spacing: .horizontalSpacing) {
                    URLImage(urlString: model.config.avatar)
                        .frame(width: size)
                        .clipShape(Circle())
                    URLImage(urlString: model.config.avatar)
                        .frame(width: size)
                        .clipShape(Circle())
                    URLImage(urlString: model.config.avatar)
                        .frame(width: size)
                        .clipShape(Circle())
                    Image(systemName: "multiply")
                        .thinBlurBackground(shape: Circle())
                        .frame(width: size)
                }.padding(.trailing, .horizontalSpacing)
            }
        }
    }
}

private struct DrawingConstants {
    static let bottomAreaHeight: CGFloat = 35
    static let topBarHeightFactor: CGFloat = 0.06329
    static let imageSizeFactor: CGFloat = 0.089
}
