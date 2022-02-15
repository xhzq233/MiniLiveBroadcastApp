//
//  PublicBoardViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/14.
//

import Foundation
import SwiftUI

class PublicBoardViewModel:ObservableObject {
    @Published var edittingText:String = ""
    @Published var keyBoardBottomPadding:CGFloat = .bottomPadding
    
}
