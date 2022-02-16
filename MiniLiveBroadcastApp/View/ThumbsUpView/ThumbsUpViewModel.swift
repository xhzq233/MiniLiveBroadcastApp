//
//  ThumbsUpView.ViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/15.
//

import SwiftUI

class ThumbsUpViewModel: ObservableObject {
    
    typealias ThumbsUp = ThumbsUpModel.ThumbsUp
    
    @Published var model = ThumbsUpModel()
    
    var thumbsUp: ThumbsUp {
        model.thumbsUp
    }
    
    func changeAlive() {
        model.changeAlive()
    }
    
    func makeAThumbsUp() {
        model.makeAThumbsUp()
    }
    
}
