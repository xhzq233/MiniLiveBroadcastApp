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
    case loadingVideo //present preview time
    case videoLoaded
    case fail(err: String)
}

class VideoPlayerManager: NSObject {
    private var asset: AVAsset?
    private var player: AVQueuePlayer?
    private var playerItem: AVPlayerItem?
    private var playerLooper: AVPlayerLooper?

    //avoid reference cycle
    weak var delegate: VideoPlayerDelegate?

    func setPlayerSourceUrl(url: String, playerLayer: AVPlayerLayer) {
        if let sourceURL = URL(string: url) {
            asset = AVAsset(url: sourceURL)
            if let asset = asset {
                playerItem = AVPlayerItem(asset: asset)
                player = AVQueuePlayer(playerItem: playerItem)

                player?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new, .initial, .old], context: nil)

                if let player = player, let playerItem = playerItem {
                    playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
                }

                playerLayer.player = player
                addProgressObserver()
            }

        }
    }

    func disposePlayer() {
        pause()
        asset = nil
        player = nil
        playerItem = nil
        playerLooper = nil
    }


    //to play or pause
    func updatePlayerState() {
        if player?.rate == 0 {
            play()
        } else {
            player?.pause()
        }
    }

    func play() {
        player?.play()
    }

    /// pause with reset time line
    func pause() {
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
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

        if keyPath == #keyPath(AVPlayerItem.status) {
            switch player?.status {
            case .unknown:
                // Player item is not yet ready.
                delegate?.onPlayItemStatusUpdate(status: .loadingVideo)
            case .readyToPlay:
                // Player item is ready to play.
                delegate?.onPlayItemStatusUpdate(status: .videoLoaded)
            case .failed:
                // Player item failed. See error.
                delegate?.onPlayItemStatusUpdate(status: .fail(err: playerItem?.error?.localizedDescription ?? ""))
            case .none:
                delegate?.onPlayItemStatusUpdate(status: .fail(err: playerItem?.error?.localizedDescription ?? "none"))
            @unknown default:
                delegate?.onPlayItemStatusUpdate(status: .loadingVideo)
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    private func addProgressObserver() {
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: .main) { [weak self] time in
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
