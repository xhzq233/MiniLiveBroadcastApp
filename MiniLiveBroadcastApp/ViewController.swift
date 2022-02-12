//
//  ViewController.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/4.
//

import UIKit

class ViewController: UIViewController {

    let scrollView = ScrollPageView(frame: CGRect(x: 0, y: 0, width: .screenWidth, height: .screenHeight)) { _, index in
            .instances.getElement(at: index) ?? .instances[0]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // disable bar
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(scrollView)

        scrollView.setFilledConstraint(in: view)
    }
}
