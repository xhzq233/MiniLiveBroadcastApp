//
//  ScrollPageViewCell.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import UIKit

/// SinglePage in ScrollView
class ScrollPageViewCell: UICollectionViewCell {
    
    var config:ScrollPageCellConfigure!
    var preview:UIImageView = UIImageView(frame: .zero)
    var title:UILabel = UILabel(frame: .zero)
    
    func loadConfigure(config:ScrollPageCellConfigure) -> Self{
        self.config = config
        title.text = config.title
        preview.image = UIImage(systemName: config.previewImage)
        return self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // preview
        addSubview(preview)
        preview.contentMode = .scaleAspectFill
        preview.backgroundColor = .clear
        
        preview.setFilledConstraint(in: self)
        backgroundColor = .brown
        
        //title
        addSubview(title)
        title.numberOfLines = 1
        title.lineBreakMode = .byTruncatingTail
        title.font = .systemFont(ofSize: 30)
        title.textAlignment = .center
        
        title.activateConstraint([
            title.topAnchor.constraint(equalTo: topAnchor,constant: 30),
            title.heightAnchor.constraint(equalToConstant: 70),
            title.leftAnchor.constraint(equalTo: leftAnchor),
            title.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
