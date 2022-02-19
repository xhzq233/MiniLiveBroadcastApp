//
//  VideoPlayerManager.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import AVFoundation
import UIKit

protocol VideoPlayerDelegate: AnyObject {
    // progress change
    func onProgressUpdate(current: CGFloat, total: CGFloat)
    // callback when status change
    func onPlayItemStatusUpdate(status: VideoPlayStatus)
}

enum VideoPlayStatus: Equatable {
    case none  //not start yet
    case loadingVideo  //present preview time
    case videoLoaded
    case fail(err: String)
}

class VideoPlayerManager: NSObject {
    private var asset: AVAsset?
    private var player: AVQueuePlayer?
    private var playerItem: AVPlayerItem?
    private var playerLooper: AVPlayerLooper?
    let playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer()
        layer.videoGravity = .resizeAspectFill  //fill the screen
        return layer
    }()

    private(set) var status: VideoPlayStatus = .none

    var isPlaying: Bool {
        rate != 0 && status == .videoLoaded
    }

    //avoid reference cycle
    weak var delegate: VideoPlayerDelegate?

    func setPlayerSourceUrl(url: String) {

        guard status == .none && !isPlaying else { return }
        if let sourceURL = URL(string: url) {
            asset?.cancelLoading()
            removeObserver()
            asset = AVAsset(url: sourceURL)
            if let asset = asset {
                playerItem = AVPlayerItem(asset: asset)
                player = AVQueuePlayer(playerItem: playerItem)

                player?.addObserver(
                    self,
                    forKeyPath: #keyPath(AVPlayerItem.status),
                    options: [.new, .initial, .old],
                    context: nil
                )

                if let player = player, let playerItem = playerItem {
                    playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
                }

                playerLayer.player = player
                addProgressObserver()
            }

        }
    }

    func disposePlayer() {
        player?.pause()
        status = .none
        asset = nil
        player = nil
        playerItem = nil
        playerLayer.player = nil
        playerLooper = nil
        removeObserver()
    }

    /// to play or pause
    func updatePlayerState() {
        if !isPlaying {
            player?.play()
        } else {
            player?.pause()
        }
    }

    func play() {
        if !isPlaying {
            player?.play()
        }
    }

    /// pause with reset time line
    ///
    /// pauseVideo if video is playing or is loading
    /// i.e ur video is loading while it isnt playing, causing that multi videos playing at a same time
    func pauseAndSeek2Zero() {
        //        if isPlaying || status == .loadingVideo {
        //            videoManager.pauseAndSeek2Zero()
        //        }
        player?.pause()
        player?.seek(to: .zero)
    }

    var rate: CGFloat {
        CGFloat(player?.rate ?? 0)
    }
    var timeObserverToken: Any?
}

extension VideoPlayerManager {

    /// bugs?
    /// player item wont notify state changing sometime
    /// so i chose player
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?
    ) {

        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: VideoPlayStatus

            switch player?.status {
            case .unknown:
                // Player item is not yet ready.
                status = .loadingVideo
            case .readyToPlay:

                // why player is ready but asset?.isPlayable is false
                if asset?.isPlayable == true && playerItem?.error == nil && player?.error == nil {
                    //                         Player item is ready to play.
                    status = .videoLoaded
                } else {
                    status = .fail(err: playerItem?.error?.localizedDescription ?? "Unknown Error")
                }
            case .failed:
                status = .fail(err: player?.error?.localizedDescription ?? "Unknown Error")
            // Player item failed. See error.
            case .none:
                status = .fail(err: "nil value")
            @unknown default:
                status = .none
            }
            self.status = status
            delegate?.onPlayItemStatusUpdate(status: status)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    private func addProgressObserver() {
        timeObserverToken = player?.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)),
            queue: .main
        ) { [weak self] time in
            let current = CMTimeGetSeconds(time)
            let total = CMTimeGetSeconds(self?.playerItem?.duration ?? CMTime())
            self?.delegate?.onProgressUpdate(current: CGFloat(current), total: CGFloat(total))
        }
    }

    func removeObserver() {
        playerItem?.removeObserver(self, forKeyPath: "status")
        if let timeObserverToken = timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
}
