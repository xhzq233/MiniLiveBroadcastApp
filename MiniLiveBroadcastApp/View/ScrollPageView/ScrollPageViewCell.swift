//
//  ScrollPageViewCell.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import UIKit
import SwiftUI

/// SinglePage in ScrollView
class ScrollPageViewCell: UITableViewCell {

    private var config: ScrollPageCellConfigure = .defaultConfigure

    private let title: UILabel = UILabel(frame: .zero)
    private let playerView: VideoPlayerView = VideoPlayerView()
    private let more = UIImageView(image: UIImage(systemName: "ellipsis.circle"))

    var isPlaying: Bool {
        playerView.isPlaying
    }

    /// dispose player before reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = .LoadingTitle
        playerView.disposePlayer()
    }

    deinit {
        print("deinit!! \(config.title)")
        playerView.disposePlayer()
    }

    func pauseVideo() {
        print("\(config.title) pauseVideo")
        playerView.pause()
    }

    func setConfigure(config: ScrollPageCellConfigure) {
        self.config = config
    }

    /// load preview image and title
    func load() {
        playerView.showPreview(with: config.previewImage)
        self.title.text = self.config.title
    }

    /// loadVideo if cell not playing
    func loadVideo() {
        if !isPlaying {
            if playerView.status == .videoLoaded {
                //if already loaded, just play
                print("\(config.title) playVideo")
                playerView.play()
            } else {
                print("\(config.title) loadVideoSource")
                playerView.loadVideoSource(with: config.video)
            }
        }
    }

    /// make textcolor inherited from tint color
    override func tintColorDidChange() {
        title.textColor = tintColor
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black

        //player view
        contentView.addSubview(playerView)
        playerView.setFilledConstraint(in: contentView)
        
        //title
        contentView.addSubview(title)
        title.numberOfLines = 1
        title.lineBreakMode = .byTruncatingTail
        title.font = .systemFont(ofSize: 30)
        title.textAlignment = .center

        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(CGFloat.topPadding)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }

        //more view
        contentView.addSubview(more)
        more.contentMode = .scaleAspectFit
        more.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pressMore)))

        more.snp.makeConstraints {
            $0.top.equalToSuperview().offset(CGFloat.topPadding)
            $0.right.equalToSuperview().offset(-1 * CGFloat.horizontalPadding)
            $0.size.equalTo(CGFloat.iconSize)
        }

        title.text = .LoadingTitle
    }

    @objc func pressMore() {

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
