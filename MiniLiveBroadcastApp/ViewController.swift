//
//  ViewController.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/4.
//

import UIKit

class ViewController: UIViewController {

    let scrollView = ScrollPageView(frame: CGRect(x: 0, y: 0, width: .screenWidth, height: .screenHeight)) { _, index in
        ScrollPageCellConfigure(title: "Page\(index)", previewImage: "globe.americas", video: "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(scrollView)

        scrollView.setFilledConstraint(in: view)
    }
}
