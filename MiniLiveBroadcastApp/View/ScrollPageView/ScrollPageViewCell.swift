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

    private let preview: UIImageView = UIImageView(frame: .zero)
    private let title: UILabel = UILabel(frame: .zero)
    private let playerView:VideoPlayerView = VideoPlayerView()
    private let more = UIImageView(image: UIImage(systemName: "ellipsis.circle"))
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadDefault()
    }

    func loadDefault() {
        config = .defaultConfigure
        title.text = config.title
        
        preview.image = UIImage(named: config.previewImage)
    }

    deinit{
        //TODO: job dispose
    }
    
    func loadConfigure(config: ScrollPageCellConfigure) -> Self {
        self.config = config
        preview.loadUrlImage(from: config.previewImage)
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(1)
            DispatchQueue.main.async { [unowned self] in
                title.text = config.title
            }
        }
        return self
    }

    func loadVideo() {
        preview.alpha = 0
    }

    //make textcolor inherited from tint color
    override func tintColorDidChange() {
        title.textColor = tintColor
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // preview
        contentView.addSubview(preview)
        preview.contentMode = .scaleAspectFit
        preview.backgroundColor = .clear
        
        //add blurEffect to preview
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
        blurEffectView.frame = preview.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        preview.addSubview(blurEffectView)
        
        preview.setFilledConstraint(in: contentView)
        
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
            more.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: .horizontalPadding * (-1)),
            more.heightAnchor.constraint(equalToConstant: .iconSize),
            more.widthAnchor.constraint(equalToConstant: .iconSize)
        ])
        
        //player view
        contentView.addSubview(playerView)
        playerView.setFilledConstraint(in: contentView)
        loadDefault()
    }

    @objc func pressMore(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
