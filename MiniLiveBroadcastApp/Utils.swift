//
//  Utils.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/11.
//

import Foundation
import UIKit


extension Double {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

extension CGFloat {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

extension UIView {
    func setFilledConstraint(in view:UIView){
        activateConstraint([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func activateConstraint(_ constraints: [NSLayoutConstraint]){
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
