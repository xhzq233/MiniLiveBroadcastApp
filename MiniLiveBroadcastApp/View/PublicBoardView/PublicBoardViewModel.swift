//
//  PublicBoardViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/14.
//

import SwiftUI

protocol PublicBoardViewPageChangedDelegate: AnyObject {
    func onPageDidChanged()
    func onPageEndDisplay()
}

class PublicBoardViewModel: ObservableObject {
    // set config when page changed
    func setConfig(config: ScrollPageCellConfigure) {
        self.config = config
        onPageChanged()
    }

    var config: ScrollPageCellConfigure = .defaultConfigure
    weak var delegate: PublicBoardViewPageChangedDelegate?

    @Published var progress: CGFloat = .zero
    @Published var isVideoLoadFailed = false
    @Published var isVideoReady = false
    @Published var isShowGiftChooser = false
    @Published var isMoreShowed = true
    @Published var isFollowed = false
    
    let videoManager = VideoPlayerManager()

    var errorDescription: String = ""

    /// time to loadVideo and PublicBoardView if page changed
    /// exceptional case: view first appear
    func onPageChanged() {
        //reset
        errorDescription = ""
        isMoreShowed = true
        isVideoLoadFailed = false
        isVideoReady = false
        isShowGiftChooser = false
        isMoreShowed = true
        isFollowed = false
        
        delegate?.onPageDidChanged()
        if videoManager.status == .videoLoaded {
            //if already loaded, just play
            videoManager.play()
        } else if videoManager.status == .none {
            // none start yet
            videoManager.setPlayerSourceUrl(url: config.video)
        }
    }

    func onPageEndDisplay() {
        delegate?.onPageEndDisplay()
        isVideoReady = false
        videoManager.disposePlayer()
    }

    /// to play or pause
    /// send `will change` to animate play status hint
    func updatePlayerState() {
        videoManager.updatePlayerState()
        objectWillChange.send()
    }

    init() {
        videoManager.delegate = self
    }
}

extension PublicBoardViewModel: VideoPlayerDelegate {
    func onProgressUpdate(current: CGFloat, total: CGFloat) {
        let temp = current / total
        progress = temp < 1.0 ? temp : 1.0
    }

    func onPlayItemStatusUpdate(status: VideoPlayStatus) {
        switch status {
        case .loadingVideo:
            break
        case .videoLoaded:
            isVideoReady = true
            // auto play when is ready
            videoManager.play()
            break
        case .fail(let err):
            isVideoLoadFailed = true
            errorDescription = err
            break
        case .none:  //wont arrive here
            break
        }
    }
}
