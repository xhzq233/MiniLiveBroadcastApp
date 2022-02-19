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

        //MARK: test
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
//            self.bulletChattingViewModel.fire(
//                Bullet(
//                    prefix: Bullet.prefixStrings.randomElement()!,
//                    sender: User.instances.randomElement()!,
//                    content: "2333"
//                )
//            )
//        }
    }

    //MARK: models
    @ObservedObject private var model: PublicBoardViewModel
    private let textFieldModel: AutoFitTextFieldViewModel
    private let giftsViewModel: GiftsViewModel = GiftsViewModel()
    private let bulletChattingViewModel: BulletChattingViewModel = BulletChattingViewModel()

    //MARK: Layers
    private var playerLayer: some View {
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
    }
    private var giftChooser:some View {
        LazyHGrid(rows: columnGrids) {
            ForEach([Int](Gift.id2url.keys), id: \.self) { key in
                URLImage(urlString: Gift.id2url[key]!)
                    .onTapGesture {
                        giftsViewModel.fire(Gift(sender: User.instances[0], giftID: key))
                    }
            }
        }
    }

    private var controllerLayer: some View {
        VStack(alignment: .leading) {
            topBar
                .frame(maxHeight: .screenHeight / 15)
            Spacer(minLength: 0)  //blank area .screenHeight / 4
            GiftsView(model: giftsViewModel)
            BulletChattingView(model: bulletChattingViewModel)
            bottomBar
            if model.isShowGiftChooser {
                giftChooser
                    .transition(.move(edge: .bottom).combined(with: .opacity).combined(with: .scale))
            }
            ProgressView(value: model.progress)
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 10)
    }

    var body: some View {
        Group {
            if model.isVideoReady {  // use `if` to avoid pre load
                ZStack {
                    playerLayer
                    controllerLayer
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

    private let columnGrids = [
        GridItem(.flexible()), GridItem(.flexible()),
    ]

    //MARK: bottomBar
    private var bottomBar: some View {
        HStack(spacing: .horizontalSpacing) {
            AutoFitTextFieldView(model: textFieldModel) { content in
                //notice that content type is Bind<String>
                bulletChattingViewModel.fire(
                    Bullet(
                        prefix: Bullet.prefixStrings.randomElement()!,
                        sender: User.instances.randomElement()!,
                        content: content.wrappedValue
                    )
                )
                content.wrappedValue = ""
            }
            Image(systemName: "suit.heart.fill")
                .onTapGesture {
                    giftsViewModel.fire(Gift.instances.randomElement()!)
                }
                .foregroundColor(.pink)
                .thinBlurBackground(shape: Circle())
            Image(systemName: "gift")
                .foregroundColor(.pink)
                .onTapGesture {
                    withAnimation {
                        model.isShowGiftChooser.toggle()
                    }
                }
                .thinBlurBackground(shape: Circle())
            Image(systemName: "ellipsis.circle")
                .thinBlurBackground(shape: Circle())
        }
    }

    //MARK: topBar
    private var topBar: some View {
        GeometryReader { geo in
            let size = geo.size.width * DrawingConstants.imageSizeFactor
            HStack(spacing: .horizontalSpacing) {
                HStack {
                    URLImage(urlString: model.config.avatar)
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                    Text(model.config.title)
                        .font(.caption2)
                        .lineLimit(1)
                    Text( model.isFollowed ? String.UnFollow : String.Follow)
                        .onTapGesture {
                            model.isFollowed.toggle()
                        }
                        .font(.caption)
                        .foregroundColor(model.isFollowed ? .red :.white)
                        .frame(width: size * 1.2)
                        .lineLimit(1)
                        .padding(2)
                        //this is margin, inner view padding to container view
                        .background(model.isFollowed ? .gray : .red, in: Capsule())
                        .padding(.horizontal, 2)
                }
                .background(.thinMaterial, in: Capsule())

                Spacer(minLength: size * 2)
                HStack(spacing: .horizontalSpacing) {
                    Group {
                        URLImage(urlString: model.config.avatar)
                        URLImage(urlString: model.config.avatar)
                        URLImage(urlString: model.config.avatar)
                    }  // use group to animate together
                    .frame(width: size)
                    .clipShape(Circle())
                    .opacity(model.isMoreShowed ? 1 : 0)
                    .scaleEffect(model.isMoreShowed ? 1 : 0.5)
                    .offset(x: model.isMoreShowed ? 0 : size * 2, y: 0)
                    Image(systemName: "multiply")
                        .rotationEffect(model.isMoreShowed ? .radians(.pi / 2) : .zero)
                        .thinBlurBackground(shape: Circle())
                        .frame(width: size)
                        .onTapGesture {
                            // explicit animation
                            withAnimation {
                                model.isMoreShowed.toggle()
                            }
                        }
                }
            }
            .frame(maxHeight: size * 2)
        }
    }
}

private struct DrawingConstants {
    static let bottomAreaHeight: CGFloat = 35
    static let topBarHeightFactor: CGFloat = 0.06329
    static let imageSizeFactor: CGFloat = 0.089
}
