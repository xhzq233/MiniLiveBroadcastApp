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
    static let LoadingTitle = "Coming Soon..."
    static let LoadingSystemImage = "hourglass"


}

extension ScrollPageCellConfigure {

    static let defaultConfigure = ScrollPageCellConfigure(title: "Default", previewImage: "https://img.zcool.cn/community/01a2415ae121b5a801214a61dae070.jpg@1280w_1l_2o_100sh.jpg", video: "file:///Users/xhz/Desktop/background.nosync/%E5%9B%8Dfin.mp4")

    static let instances = [
        ScrollPageCellConfigure(title: "xhzq233", previewImage: "https://img.zcool.cn/community/0173a75b29b349a80121bbec24c9fd.jpg@1280w_1l_2o_100sh.jpg", video: "http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4"),
        ScrollPageCellConfigure(title: "xhzq234", previewImage: "https://i0.hdslb.com/bfs/face/eb6a64203e088fb08ab447d75c1842e440611cba.jpg@240w_240h_1c_1s.webp", video: "http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4"),
        ScrollPageCellConfigure(title: "xhzq235", previewImage: "https://i0.hdslb.com/bfs/face/eb6a64203e088fb08ab447d75c1842e440611cba.jpg@240w_240h_1c_1s.webp", video: "https://www.w3school.com.cn/example/html5/mov_bbb.mp4"),
        ScrollPageCellConfigure(title: "xhzq236", previewImage: "https://i0.hdslb.com/bfs/face/eb6a64203e088fb08ab447d75c1842e440611cba.jpg@240w_240h_1c_1s.webp", video: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"),
        ScrollPageCellConfigure(title: "xhzq237", previewImage: "https://i0.hdslb.com/bfs/face/eb6a64203e088fb08ab447d75c1842e440611cba.jpg@240w_240h_1c_1s.webp", video: "https://media.w3.org/2010/05/sintel/trailer.mp4"),
    ]
}
