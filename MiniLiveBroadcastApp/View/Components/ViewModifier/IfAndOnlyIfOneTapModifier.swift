//
//  IfAndOnlyIfOneTapModifier.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/17.
//

import SwiftUI

typealias TapCallBack = (CGPoint) -> Void

extension View {
    func ifAndOnlyIfOneTap(onTap: @escaping TapCallBack, onMoreTap: @escaping TapCallBack)
        -> some View
    {
        self.overlay(Overlay(onTap: onTap, onMoreTap: onMoreTap))
    }
}

/// wrapped into overLay to responded in swiftUI
struct Overlay: UIViewRepresentable {
    let onTap: TapCallBack

    let onMoreTap: TapCallBack

    func makeUIView(context: Context) -> UIView {
        IfAndOnlyIfOneTapView(onTap: onTap, onMoreTap: onMoreTap)
    }

    func updateUIView(
        _ uiView: UIView,
        context: Context
    ) {
    }

}

class IfAndOnlyIfOneTapView: UIView {
    let onTap: TapCallBack
    var lastTapTime: Double = .zero
    let onMoreTap: TapCallBack

    var timer: Timer?

    init(onTap: @escaping TapCallBack, onMoreTap: @escaping TapCallBack) {
        self.onMoreTap = onMoreTap
        self.onTap = onTap
        super.init(frame: .zero)

        self.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(handleGesture))
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleGesture(sender: UITapGestureRecognizer) {
        //location
        let point = sender.location(in: self)

        let time = CACurrentMediaTime()

        if (time - lastTapTime) > Self.divideTapGapTime {
            // need to judge isDoubleClick so delay divideTapGap
            timer = Timer.init(timeInterval: Self.divideTapGapTime, repeats: false) {
                [weak self] _ in
                self?.onTap(point)
            }
            if let timer = timer {
                RunLoop.current.add(timer, forMode: .default)
            }
        } else {
            //cancel
            timer?.invalidate()
            addHand(at: point)
            onMoreTap(point)
        }
        lastTapTime = time
    }

    // add thumbs up animation
    func addHand(at position: CGPoint) {
        let likeImageView = UIImageView.init(image: UIImage.init(systemName: "hand.thumbsup.fill"))

        self.addSubview(likeImageView)
        likeImageView.tintColor = .red

        likeImageView.frame = CGRect.init(
            origin: position,
            size: Self.thumbsUpSize
        )

        likeImageView.transform = CGAffineTransform(rotationAngle: -Self.angle).scaledBy(x: 0.8, y: 0.8)

        UIView.animate(withDuration: Self.secondStageAnimeTime) {
            likeImageView.transform = CGAffineTransform.init(rotationAngle: Self.angle)
        } completion: { _ in
            UIView.animate(
                withDuration: Self.secondStageAnimeTime
            ) {
                likeImageView.transform = CGAffineTransform.init(scaleX: 3.0, y: 3.0)
                likeImageView.alpha = 0.0
            } completion: { _ in
                likeImageView.removeFromSuperview()
            }
        }
    }

    /// time interval to judge isDoubleClick
    static let divideTapGapTime = 0.25

    static let firstStageAnimeTime = 0.25
    static let secondStageAnimeTime = 0.4
    static let thumbsUpSize = CGSize.init(width: 80, height: 80)
    static let angle = Double.pi / 6.5
}
