//
//  VideoPlayerView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    private var videoManager = VideoPlayerManager()
    private let playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer()
        layer.videoGravity = .resizeAspectFill //fill the screen
        return layer
    }()

    //default presenting image when view appear
    private let preview = UIImageView(image: UIImage(systemName: .LoadingSystemImage))
    private(set) var status: VideoPlayStatus = .loadingVideo

    func showPreview(with url: String) {
        preview.loadUrlImage(from: url)
    }

    var isPlaying: Bool {
        videoManager.rate != 0 && status == .videoLoaded
    }

    func loadVideoSource(with url: String) {
        playerLayer.isHidden = false
        videoManager.setPlayerSourceUrl(url: url, playerLayer: playerLayer)
    }

    func play() {
        videoManager.play()
    }

    /// pauseVideo if video is playing or is loading
    /// i.e ur video is loading while it isnt playing, causing that multi videos playing at a same time
    func pause() {
        if isPlaying || status == .loadingVideo {
            videoManager.pause()
        }
    }

    func disposePlayer() {
        preview.isHidden = false
        status = .loadingVideo
        playerLayer.isHidden = true
        videoManager.disposePlayer()
    }

    // init and set layout
    override init(frame: CGRect) {
        super.init(frame: frame)
        videoManager.delegate = self

        // preview
        self.addSubview(preview)
        preview.contentMode = .scaleAspectFit

        // add blurEffect to preview
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
        blurEffectView.frame = preview.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        preview.addSubview(blurEffectView)

        preview.setFilledConstraint(in: self)
        layer.addSublayer(playerLayer)
    }


    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        playerLayer.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension VideoPlayerView: VideoPlayerDelegate {
    func onProgressUpdate(current: CGFloat, total: CGFloat) {
//        print("current:\(current) total:\(total)")
    }

    func onPlayItemStatusUpdate(status: VideoPlayStatus) {
        self.status = status
        switch status {
        case .loadingVideo:
            break
        case .videoLoaded:
            preview.isHidden = true
            play()
        case .fail(let err):
            let hint = UILabel()
            self.addSubview(hint)
            hint.text = err
            hint.textAlignment = .center
            hint.setFilledConstraint(in: self)
            hint.textColor = .red
            hint.font = .systemFont(ofSize: 40)
            UIView.animate(withDuration: 2) {
                hint.alpha = 0
            } completion: { _ in
                hint.removeFromSuperview()
            }
        }
    }

}
