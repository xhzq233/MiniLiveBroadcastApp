//
//  Constant.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import UIKit

extension Int {
    static let defaultPageCount = 3
}

extension Double {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

extension CGFloat {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let topPadding = CGFloat(40)
    static let horizontalPadding = CGFloat(20)
    static let iconSize = CGFloat(30)
}

extension String {
    static let PageCellIdentifier = "PageCell"
}

extension ScrollPageCellConfigure {
    //used on preview before network resources loaded...
    static let defaultConfigure = ScrollPageCellConfigure(title: "coming soon...", previewImage: "hourglass", video: "")

    static let instances = [
        ScrollPageCellConfigure(title: "xhzq233", previewImage: "https://i0.hdslb.com/bfs/face/eb6a64203e088fb08ab447d75c1842e440611cba.jpg@240w_240h_1c_1s.webp", video: "https://www.bilibili.com/video/BV1NM4y1N7MK?p=5&t=44.2"),
        ScrollPageCellConfigure(title: "xhzq234", previewImage: "https://i0.hdslb.com/bfs/face/eb6a64203e088fb08ab447d75c1842e440611cba.jpg@240w_240h_1c_1s.webp", video: "https://www.bilibili.com/video/BV1NM4y1N7MK?p=5&t=44.2"),
        ScrollPageCellConfigure(title: "xhzq235", previewImage: "https://i0.hdslb.com/bfs/face/eb6a64203e088fb08ab447d75c1842e440611cba.jpg@240w_240h_1c_1s.webp", video: "https://www.bilibili.com/video/BV1NM4y1N7MK?p=5&t=44.2"),
        ScrollPageCellConfigure(title: "xhzq236", previewImage: "https://i0.hdslb.com/bfs/face/eb6a64203e088fb08ab447d75c1842e440611cba.jpg@240w_240h_1c_1s.webp", video: "https://www.bilibili.com/video/BV1NM4y1N7MK?p=5&t=44.2")
    ]
}
