//
//  ScrollPageView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/11.
//

import UIKit

extension ScrollPageView: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        (collectionView.dequeueReusableCell(withReuseIdentifier: .PageCellIdentifier, for: indexPath) as! ScrollPageViewCell)
                .loadConfigure(config: pageConfigureBuilder(self, indexPath.item))
    }


    //结束页面的滑动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        //TODO: - video load
    }

    //开始拖动时
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

    }
}


class ScrollPageView: UICollectionView {

    var itemCount: Int = .defaultCollectionPageCount

    func loadmore() {
        itemCount += .defaultCollectionPageCount
        reloadData()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if contentOffset.y > contentSize.height - frame.height {
            loadmore()
        } else if contentOffset.y < 0 {
            contentOffset = .zero // disable the header
        }
    }

    private let pageConfigureBuilder: PageConfigureBuilder

    private let layout = UICollectionViewFlowLayout()

    init(frame: CGRect, pageConfigureBuilder: @escaping PageConfigureBuilder) {
        self.pageConfigureBuilder = pageConfigureBuilder

        super.init(frame: frame, collectionViewLayout: layout)

        //full screen item size
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        layout.sectionInset = .zero
        layout.minimumLineSpacing = .zero //disable spacing

        alwaysBounceVertical = false
        showsVerticalScrollIndicator = false

        //turn to page
        isPagingEnabled = true

        //delegate
        delegate = self
        dataSource = self
        register(ScrollPageViewCell.self, forCellWithReuseIdentifier: .PageCellIdentifier)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


