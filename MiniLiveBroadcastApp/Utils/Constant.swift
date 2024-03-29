//
//  Constant.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import UIKit

extension Int {
    static let defaultPageCount = 10
}

extension CGFloat {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

    static let topPadding = CGFloat(40)
    static let bottomPadding = CGFloat(20)
    static let horizontalPadding = CGFloat(20)
    static let backgroundPadding = CGFloat(9)

    static let iconSize = CGFloat(30)

    static let horizontalSpacing = CGFloat(6)
}

extension String {

    static let PageCellIdentifier = "PageCell"
    static let LoadingTitle = "Coming Soon..."
    static let LoadingSystemImage = "hourglass"

    static let PublicBoardTextFieldHint = "说点什么..."
    static let Follow = "关注"
    static let UnFollow = "已关注"
}

extension ScrollPageCellConfigure {

    static let titokAvatar =
        "https://tse3-mm.cn.bing.net/th/id/OIP-C.-tnna94uAIeB64iqitjRVwHaHU?pid=ImgDet&rs=1"

    static let bilibiliPersonAvatar =
        "https://i0.hdslb.com/bfs/face/eb6a64203e088fb08ab447d75c1842e440611cba.jpg@240w_240h_1c_1s.webp"

    static let genshinAyaka = "https://s1.zerochan.net/Ayaka.(Genshin.Impact).600.3144723.jpg"

    static let raidenShogun1 =
        "https://progameguides.com/wp-content/uploads/2021/07/Genshin-Impact-Character-Raiden-Shogun-1.jpg"

    static let raidenShogun2 = "https://s1.zerochan.net/Raiden.Shogun.600.3422063.jpg"

    static let yae = "https://staticg.sportskeeda.com/editor/2021/04/67d38-16189431025087.png"

    static let yanFei =
        "https://tse4-mm.cn.bing.net/th/id/OIP-C.AhMgCypX_J3trIv93H0s1wHaIp?pid=ImgDet&w=514&h=600&rs=1"
    static let avatars = [
        titokAvatar,
        bilibiliPersonAvatar,
        genshinAyaka,
        raidenShogun1,
        raidenShogun2,
        yae,
        yanFei,
    ]

    static let localVideo = "file:///Users/xhz/Desktop/background.nosync/%E5%9B%8Dfin.mp4"

    static let defaultConfigure = ScrollPageCellConfigure(
        title: "Default",
        previewImage: bilibiliPersonAvatar,
        video: localVideo,
        avatar: bilibiliPersonAvatar
    )

    static let videos = [
        "http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4",
        "http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4",
        "https://www.w3school.com.cn/example/html5/mov_bbb.mp4",
        "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
        "https://media.w3.org/2010/05/sintel/trailer.mp4",
    ]

    static let instances: [ScrollPageCellConfigure] = (0...10).map { i -> ScrollPageCellConfigure in
        ScrollPageCellConfigure(
            title: "Video \(i)",
            previewImage: titokAvatar,
            video: videos.randomElement() ?? localVideo,
            avatar: avatars.randomElement() ?? bilibiliPersonAvatar
        )
    }
}

extension Gift {
    static let instances: Gifts =
        User.instances.map { user in
            Gift(sender: user, giftID: 0)
        }
}

extension Bullet {
    static let prefixStrings = [
        "⚽️7 ",
        "🥎4 ",
        "🎱3 ",
        "🏐2 ",
        "🏀1 ",
        "🐤6 ",
        "🐶5 ",
    ]
}

extension User {

    static let names = [
        "xhzq233",
        "Maihh",
        "TikTok",
        "Yae",
        "RaidenShogun",
        "Ayaka",
        "YanFei",
    ]

    static let instances: Users =
        ScrollPageCellConfigure.avatars.map { str in
            User(avatar: str, userName: names.randomElement()!)
        }
}


extension Notification.Name {
    static let giftMessage = Notification.Name("GiftMessage")
}
