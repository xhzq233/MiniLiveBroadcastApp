//
//  IfAndOnlyIfOneTapModifier.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/17.
//

import SwiftUI

typealias TapCallBack = (CGPoint) -> Void

struct IfAndOnlyIfOneTapViewModifier: ViewModifier {

    let onTap: TapCallBack

    let onMoreTap: TapCallBack

    func body(content: Content) -> some View {
        content
            .overlay(Overlay(onTap: onTap, onMoreTap: onMoreTap))
    }

}

extension View {
    func ifAndOnlyIfOneTap(onTap: @escaping TapCallBack, onMoreTap: @escaping TapCallBack)
        -> some View
    {
        self.modifier(IfAndOnlyIfOneTapViewModifier(onTap: onTap, onMoreTap: onMoreTap))
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
            UITapGestureRecognizer(target: self, action: #selector(handleGesture)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleGesture(sender: UITapGestureRecognizer) {
        //location
        let point = sender.location(in: self)

        let time = CACurrentMediaTime()

        if (time - lastTapTime) > .divideTapGapTime {
            // need to judge isDoubleClick so delay divideTapGap
            timer = Timer.init(timeInterval: .divideTapGapTime, repeats: false) { [weak self] _ in
                self?.onTap(point)
            }
            if let timer = timer {
                RunLoop.current.add(timer, forMode: .default)
            }
        } else {
            //cancel
            timer?.invalidate()
            onMoreTap(point)
        }
        lastTapTime = time
    }

}
