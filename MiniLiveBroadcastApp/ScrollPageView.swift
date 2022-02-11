//
//  ScrollPageView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/11.
//

import UIKit

extension ScrollPageView: UIScrollViewDelegate {

    //结束页面的滑动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //TODO: - video load
    }

    //开始拖动时
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
}

typealias Pages = Array<Page>

class ScrollPageView: UIScrollView {
    
    //the most important in an infinite scroll
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //if the x value is less than zero
        if contentOffset.y < 0 {
            contentOffset = CGPoint(x: contentOffset.x, y: contentSize.height - frame.height)
        }
        
        //if the x value is greater than the width - frame width
        //(i.e. when the top-right point goes beyond contentSize.width)
        else if contentOffset.y >= contentSize.height - frame.height {
            contentOffset = CGPoint(x: contentOffset.x, y: .zero)
        }
    }
    
    var pages:Pages {
        (0..<3).map {
            Page(frame: CGRect(x: 0, y: Double($0) * frame.height, width: frame.width, height: frame.height))
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        alwaysBounceVertical = false
        showsVerticalScrollIndicator = false
        backgroundColor = .blue

        //turn to page
        isPagingEnabled = true

        //delegate
        delegate = self
        
        //three pages
        contentSize = CGSize(width: frame.width, height: 3 * frame.height)
        
        pages.forEach {
            addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// SinglePage in ScrollView
class Page: UIView {

    let t = UIImageView(image: UIImage(systemName: "globe.americas"))

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(t)
        t.contentMode = .scaleAspectFit
        t.backgroundColor = .brown
        t.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            t.topAnchor.constraint(equalTo: topAnchor),
            t.bottomAnchor.constraint(equalTo: bottomAnchor),
            t.leftAnchor.constraint(equalTo: leftAnchor),
            t.rightAnchor.constraint(equalTo: rightAnchor)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
