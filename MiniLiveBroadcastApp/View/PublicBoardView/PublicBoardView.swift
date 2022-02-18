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
    let giftsViewModel: GiftsViewModel = GiftsViewModel()

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

                        }
                        .overlay(
                            Image(systemName: "play.fill")
                                .font(.system(size: .iconSize))
                                .opacity(model.videoManager.isPlaying ? 0 : 0.7)  //animatable
                                .scaleEffect(model.videoManager.isPlaying ? 1 : 3)
                        )
                    VStack {
                        topBar
                            .padding(.top, .topPadding)
                        GiftsBoxView(giftsViewModel)
                            .position(x: .screenWidth / 3.5, y: .screenHeight / 1.3)
                        BulletChattingView()
                        bottomBar
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
                primaryButton: .default(
                    Text("Load Again"),
                    action: {
                        // reload
                        model.onPageEndDisplay()
                        model.onPageChanged()
                    }
                ),
                secondaryButton: .cancel((Text("Ok")))
            )
        }
    }

    var bottomBar: some View {
        HStack(spacing: .horizontalSpacing) {
            AutoFitTextFieldView(model: textFieldModel)
            Image(systemName: "suit.heart.fill")
                .foregroundColor(.pink)
                .thinBlurBackground(shape: Circle())
            Image(systemName: "gift")
                .foregroundColor(.pink)
                .onTapGesture {
                    withAnimation {
                        giftsViewModel.sendAGift()
                    }
                }
                .thinBlurBackground(shape: Circle())
            Image(systemName: "ellipsis.circle")
                .thinBlurBackground(shape: Circle())
        }
        .padding(.horizontal, 4)
    }

    @State var isMoreShowed = true
    var topBar: some View {
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
                        //this is margin, inner view padding to container view
                        .background(.red, in: Capsule())
                        .padding(.horizontal, 2)
                }
                .background(.thinMaterial, in: Capsule())
                .padding(.leading, .horizontalSpacing)

                Spacer(minLength: size * 2)
                HStack(spacing: .horizontalSpacing) {
                    Group {
                        URLImage(urlString: model.config.avatar)
                            .frame(width: size)
                            .clipShape(Circle())
                        URLImage(urlString: model.config.avatar)
                            .frame(width: size)
                            .clipShape(Circle())
                        URLImage(urlString: model.config.avatar)
                            .frame(width: size)
                            .clipShape(Circle())
                    }// use group to animate together
                    .opacity(isMoreShowed ? 1 : 0)
                    .scaleEffect(isMoreShowed ? 1 : 0.5)
                    .offset(x: isMoreShowed ? 0 : size * 2, y: 0)
                    Image(systemName: "multiply")
                        .rotationEffect(isMoreShowed ? .radians(.pi / 2) : .zero)
                        .thinBlurBackground(shape: Circle())
                        .frame(width: size)
                        .onTapGesture {
                            // explicit animation
                            withAnimation {
                                isMoreShowed.toggle()
                            }
                        }
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
