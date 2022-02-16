//
//  VideoPlayerView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import SwiftUI

struct VideoPlayerView: UIViewRepresentable {
    let videoManager:VideoPlayerManager

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }

    func makeUIView(context: Context) -> some UIView {
        VideoPlayerViewLayer(manager: videoManager)
    }
}

class VideoPlayerViewLayer: UIView {
    private let videoManager:VideoPlayerManager
    
    // init and set layout
    init(manager:VideoPlayerManager) {
        videoManager = manager
        super.init(frame: .zero)
        layer.addSublayer(videoManager.playerLayer)
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        videoManager.playerLayer.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
