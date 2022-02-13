//
//  ScrollPageViewCell.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import UIKit

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

    /// pauseVideo if cell video is playing or is loading video
    /// i.e ur video is loading while it isnt playing, causing that multi videos playing at a same time
    func pauseVideo() {
        if isPlaying || playerView.status == .loadingVideo {
            print("\(config.title) pauseVideo")
            playerView.pause()
        }
    }

    func setConfigure(config: ScrollPageCellConfigure) -> Self {
        self.config = config
        return self
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

        title.activateConstraint([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .topPadding),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            title.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])

        //more view
        contentView.addSubview(more)
        more.contentMode = .scaleAspectFit
        more.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pressMore)))
        more.activateConstraint([
            more.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .topPadding),
            more.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: .horizontalPadding * (-1)),
            more.heightAnchor.constraint(equalToConstant: .iconSize),
            more.widthAnchor.constraint(equalToConstant: .iconSize)
        ])

        title.text = .LoadingTitle
    }

    @objc func pressMore() {

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
