//
//  ScrollPageView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/11.
//

import UIKit
import SwiftUI

extension ScrollPageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: .PageCellIdentifier, for: indexPath) as! ScrollPageViewCell)
        cell.setConfigure(config: pageConfigureBuilder(self, indexPath.item))
        return cell
    }

    //full screen item size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //MARK: video cancel
        guard let cell = cell as? ScrollPageViewCell else {
            return
        }
        cell.pauseVideo()
        hideBoard()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //MARK: preview load
        guard let cell = cell as? ScrollPageViewCell else {
            return
        }

        cell.loadPreview()

        // load video if scroll view not scrolling
        // i.e the first initialize
        if !self.isDragging {
            print("loadVideo")
            cell.loadVideo()
            showBoard(in: cell.contentView)
        }
    }
}

extension ScrollPageView: UIScrollViewDelegate {
    //结束页面的滑动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //MARK: video load

        guard let cell = self.visibleCells.first as? ScrollPageViewCell else {
            return
        }

        cell.loadVideo()
        showBoard(in: cell.contentView)
    }
}

class ScrollPageView: UITableView {

    var itemCount: Int = .defaultPageCount
    
    //MARK: publicBoard & viewModel
    let publicBoardViewModel = PublicBoardViewModel()
    var publicBoardView:UIViewController!
    
    func setPublicBoard(rootVC:UIViewController) {
        publicBoardView = UIHostingController(rootView: PublicBoardView(model: publicBoardViewModel))
        rootVC.embed(publicBoardView)
        publicBoardView.view.backgroundColor = .clear
    }
    
    func showBoard(in view:UIView) {
        publicBoardView.view.removeFromSuperview()//make sure...
        
        view.addSubview(publicBoardView.view)
        publicBoardView.view.frame = view.bounds
    }
    
    func hideBoard() {
        publicBoardView.view.removeFromSuperview()
    }
    
    deinit {
        publicBoardView.removeFromParent()
    }
    
    //MARK: load more
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
    
    // 点按两次屏幕点赞
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touching ScrollPageView !")
        if touches.count == 2 {
            // TODO: thumbsUp()
        }
    }

    private let pageConfigureBuilder: PageConfigureBuilder

    //MARK: custom
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
