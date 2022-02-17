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
    
    // 这是和屏幕点赞相关的临时变量
    @State var doubleHitPoint: CGPoint = CGPoint()
    @State var isDoubleHit: Bool = false {
        didSet{
            if isDoubleHit {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:{
                    withAnimation{
                        isDoubleHit = false
                    }
                })
            }
        }
    }

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
                       print("你点击了: \(hitPoint.x), \(hitPoint.y)")
                    isDoubleHit = true
                    doubleHitPoint = hitPoint
                    withAnimation {
                        thumbsUpViewModel.makeAThumbsUp(at: hitPoint)
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
                        ZStack {
                    GiftsBoxView(giftsViewModel)
                        .position(x: .screenWidth / 3.5, y: .screenHeight / 1.3)
                    ThumbsUpView(viewModel: thumbsUpViewModel)
                        .position(x: .screenWidth - 40, y: .screenHeight / 2)
                    GeometryReader { geometry in
                        Thumb(thumbsUp: ThumbsUpViewModel.ThumbsUp(isAlive: true))
                            .foregroundColor(.red)
                            .scaleEffect(isDoubleHit ? 1.2 : 0)
                            .rotationEffect(Angle(degrees: Double.random(in: -60 ... -30)))
                            .position(x: doubleHitPoint.x, y: doubleHitPoint.y)
                            .opacity(isDoubleHit ? 0.8 : 0)
                            .animation(Animation.easeInOut, value: 1)
                    }
                }
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
                dismissButton: .cancel((Text("Ok")))
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
                        //this is margin, inner view padding to container view
                        .background(.red, in: Capsule())
                        .padding(.horizontal, 2)
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
