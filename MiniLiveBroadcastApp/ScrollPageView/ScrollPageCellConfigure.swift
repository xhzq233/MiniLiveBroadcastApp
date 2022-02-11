//
//  ScrollPageCellConfigure.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import Foundation

typealias Pages = Array<ScrollPageViewCell>
typealias PageConfigureBuilder = (_ index:Int)->ScrollPageCellConfigure


struct ScrollPageCellConfigure{
    let title:String
    let previewImage:String
    let video:String
}
