//
//  Utils.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/11.
//

import Foundation
import UIKit


extension UIView {
    func setFilledConstraint(in view: UIView) {
        activateConstraint([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    func activateConstraint(_ constraints: [NSLayoutConstraint]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}

extension UIImageView {
    func loadUrlImage(from str:String, completion: (()->Void)? = nil)  {
        guard let url = URL(string: str) else { return }
        URLSession.shared.dataTask(with: url) { data, _ , err in
            guard let data = data,err == nil else {
                print(err!)
                return
            }
            DispatchQueue.main.async {[unowned self] in
                image = UIImage(data: data)
                completion?()
            }
        }.resume()
    }
}


extension Collection{
    //be like getOrNull()
    func getElement(at index: Index) -> Element? {
        let isValidIndex = index >= self.startIndex && index < self.endIndex
        return isValidIndex ? self[index] : nil
    }
}
