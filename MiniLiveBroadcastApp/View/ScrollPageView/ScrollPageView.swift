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
        cell.setConfigure(config: configBuilder(self, indexPath.item))
        return cell
    }
    
    //full screen item size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //MARK: video cancel
        viewModel.onPageEndDisplay()
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
            viewModel.setConfig(config: cell.config)
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
        //waiting for better optimization
        let isPageChanged = abs(contentOffset.y - lastYOffset) - frame.height > -30
        
        if isPageChanged {
            viewModel.setConfig(config: cell.config)
            showBoard(in: cell.contentView)
        }
        lastYOffset = contentOffset.y
    }
}

extension ScrollPageView:AutoFitTextFieldDelegate{
    func onKeyboardWillShow() {
        //to avoid auto scrolled caused by keyboardWillShow
        //that will cause cell in the next screen displayed then auto load video
        self.isScrollEnabled = false
    }
    
    func onKeyboardWillDisappear() {
        self.isScrollEnabled = true
    }
}

class ScrollPageView: UITableView {
    //used to judge page changed
    var lastYOffset:CGFloat = .zero
    var itemCount: Int = .defaultPageCount
    
    //MARK: publicBoard & viewModel
    let viewModel = PublicBoardViewModel()
    var publicBoardView:UIViewController!
    
    func setPublicBoard(rootVC:UIViewController) {
        
        let model = AutoFitTextFieldViewModel()
        model.delegate = self
        publicBoardView = UIHostingController(rootView: PublicBoardView(model: viewModel, textFieldModel: model))
        
        publicBoardView.view.backgroundColor = .clear
        rootVC.embed(publicBoardView)
    }
    
    func showBoard(in view:UIView) {
        publicBoardView.view.removeFromSuperview()//make sure...
        
        view.addSubview(publicBoardView.view)
        publicBoardView.view.frame = view.bounds
    }
    
    //MARK: load more
    func loadmore() {
        itemCount += .defaultPageCount
        reloadData()
        // reloadData will dispose ur visible cells!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if contentOffset.y > contentSize.height - frame.height {
            loadmore()
        } else if contentOffset.y < 0 {
            contentOffset = .zero // disable the header
        }
    }
    
    private let configBuilder: PageConfigureBuilder
    
    //MARK: custom
    init(frame: CGRect, pageConfigureBuilder: @escaping PageConfigureBuilder) {
        configBuilder = pageConfigureBuilder
        
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
