//
//  ScrollPageView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/11.
//

import UIKit

extension ScrollPageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        (tableView.dequeueReusableCell(withIdentifier: .PageCellIdentifier) as! ScrollPageViewCell)
            .loadConfigure(config: pageConfigureBuilder(self, indexPath.item))
    }
    
    //full screen item size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .zero
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .zero
    }
}

extension ScrollPageView:UIScrollViewDelegate{
    //结束页面的滑动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //TODO: - video load
    }
    
    //开始拖动时
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
}

class ScrollPageView: UITableView {

    var itemCount: Int = .defaultPageCount

    func loadmore() {
        itemCount += .defaultPageCount
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

    init(frame: CGRect, pageConfigureBuilder: @escaping PageConfigureBuilder) {
        self.pageConfigureBuilder = pageConfigureBuilder

        super.init(frame: frame, style: .plain)
        contentInset = .zero
        alwaysBounceVertical = false
        showsVerticalScrollIndicator = false
        backgroundColor = .black
        tintColor = .white

        //turn to page
        isPagingEnabled = true

        //delegate
        delegate = self
        dataSource = self
        register(ScrollPageViewCell.self, forCellReuseIdentifier: .PageCellIdentifier)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


