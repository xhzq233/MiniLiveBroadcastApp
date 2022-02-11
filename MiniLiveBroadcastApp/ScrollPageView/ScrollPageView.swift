//
//  ScrollPageView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/11.
//

import UIKit

extension ScrollPageView: UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "111", for: indexPath)as!ScrollPageViewCell)
        return cell.loadConfigure(config:pageConfigureBuilder(indexPath.item))
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
    
    var itemCount:Int = 5
    func loadmore() {
        itemCount+=5
        reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if contentOffset.y > contentSize.height - frame.height {
            loadmore()
        }else if contentOffset.y < 0{
            contentOffset = .zero // disable the header
        }
    }
    
    private let pageConfigureBuilder:PageConfigureBuilder
    var layout = UICollectionViewFlowLayout()
    init(frame: CGRect,pageConfigureBuilder:@escaping PageConfigureBuilder) {
        self.pageConfigureBuilder = pageConfigureBuilder
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        layout.sectionInset = .zero
        layout.minimumLineSpacing = .zero
        
        alwaysBounceVertical = false
        showsVerticalScrollIndicator = false
        
        //turn to page
        isPagingEnabled = true
        
        //delegate
        delegate = self
        dataSource = self
        register(ScrollPageViewCell.self, forCellWithReuseIdentifier: "111")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


