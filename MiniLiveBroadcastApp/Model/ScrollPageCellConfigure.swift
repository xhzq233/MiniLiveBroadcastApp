//
//  ScrollPageCellConfigure.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import Foundation

typealias Pages = Array<ScrollPageViewCell>
typealias PageConfigureBuilder = (_ view: ScrollPageView, _ index: Int) -> ScrollPageCellConfigure


struct ScrollPageCellConfigure {
    //TODO: 
    let title: String
    let previewImage: String
    let video: String
    let avatar: String
    let recommend: String //next url?
}
