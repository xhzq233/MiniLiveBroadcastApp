//
//  PublicBoardViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/14.
//

import SwiftUI

class PublicBoardViewModel:ObservableObject {
    func setConfig(config: ScrollPageCellConfigure) {
        self.config = config
    }
    
    var config:ScrollPageCellConfigure = .defaultConfigure
    
    @Published var progress:CGFloat = .zero
    @Published var isVideoLoadFailed:Bool = false
    @Published var isVideoReady:Bool = false
    
    let videoManager = VideoPlayerManager()
    
    var errorDescription:String = ""
    
    /// time to loadVideo and PublicBoardView if page changed
    func onPageChanged() {
        if videoManager.status == .videoLoaded {
            //if already loaded, just play
            videoManager.play()
        } else if videoManager.status == .none {
            // none start yet
            videoManager.setPlayerSourceUrl(url: config.video)
        }
    }
    
    func onPageEndDisplay() {
        isVideoReady = false
        videoManager.disposePlayer()
    }
    
    init() {
        videoManager.delegate = self
    }
}


extension PublicBoardViewModel: VideoPlayerDelegate {
    func onProgressUpdate(current: CGFloat, total: CGFloat) {
        progress = current / total
        print(progress)
    }

    func onPlayItemStatusUpdate(status: VideoPlayStatus) {
        print(status)
        switch status {
            case .loadingVideo:
                break
            case .videoLoaded:
                isVideoReady = true
                videoManager.play()
                break
            case .fail(let err):
                isVideoLoadFailed = true
                errorDescription = err
                break
            case .none://wont arrive here
                break
        }
    }

}
