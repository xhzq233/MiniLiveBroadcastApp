//
//  Utils.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/11.
//

import Foundation
import SnapKit
import UIKit

extension UIView {
    func setFilledConstraint(in view: UIView) {
        self.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.left.equalTo(view)
            $0.right.equalTo(view)
            $0.bottom.equalTo(view)
        }
    }
}

extension UIViewController {
    func embed(_ viewController: UIViewController) {
        viewController.willMove(toParent: self)
        //        viewController.view.frame = view.bounds
        //        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}

extension UIImageView {
    func loadUrlImage(from str: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: str) else { return }
        URLSession.shared.dataTask(with: url) { data, _, err in
            guard let data = data, err == nil else {
                print(err!)
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: data)
                completion?()
            }
        }.resume()
    }
}

extension Collection {
    //be like getOrNull()
    func getElement(at index: Index) -> Element? {
        let isValidIndex = index >= self.startIndex && index < self.endIndex
        return isValidIndex ? self[index] : nil
    }
}

//ByteArray aka [UInt8]
extension FixedWidthInteger {
    var byteArray: [UInt8] {
        withUnsafeBytes(of: self.bigEndian, Array.init)
    }
}
