//
//  ViewController.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/4.
//

import UIKit

class ViewController: UIViewController {

    let scrollView = ScrollPageView(frame: CGRect(x: 0, y: 0, width: .screenWidth, height: .screenHeight))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
