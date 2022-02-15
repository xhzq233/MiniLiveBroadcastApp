//
//  ScrollPageViewCell.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import UIKit
import SnapKit

/// SinglePage in ScrollView
///
/// once cell appear,
/// first it will load default config, like title = "Coming Soon...",
/// then load preview image and title etc.
/// so put that  `loadPreview` in `func tableView(_ tableView:, willDisplay:)`,
/// another thing to note is that it need to load video besides load preview when view first appear,
/// so judge the `tableView.isDragging` when will display.
///
/// once scroll view didDecelerating, we need start load video and load `PublicBoardView` in cell
///
/// once cell `endDisplay`, pause its video , seek it to zero and remove `PublicBoardView`
class ScrollPageViewCell: UITableViewCell {

    var config: ScrollPageCellConfigure = .defaultConfigure

    private let title: UILabel = UILabel(frame: .zero)
    
    //default presenting image when view appear
    private let preview = UIImageView(image: UIImage(systemName: .LoadingSystemImage))
    
    /// dispose player before reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = .LoadingTitle
        preview.image = UIImage(systemName: .LoadingSystemImage)
    }

    deinit {
        print("deinit!! \(config.title)")
    }

    func showPreview(with url: String) {
        preview.loadUrlImage(from: url)
    }

    func setConfigure(config: ScrollPageCellConfigure) {
        self.config = config
    }

    /// load preview image and title
    func loadPreview() {
        showPreview(with: config.previewImage)
        self.title.text = self.config.title
    }

    /// make `text color` inherited from `tint color`
    override func tintColorDidChange() {
        title.textColor = tintColor
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        
        // preview
        contentView.addSubview(preview)
        preview.contentMode = .scaleAspectFit
        
        // add blurEffect to preview
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
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(CGFloat.topPadding)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        title.text = .LoadingTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
