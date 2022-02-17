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
    
    var drawLocation: (x: Double, y: Double) {
        model.hit
    }
    
    func changeAlive() {
        model.changeAlive()
    }
    
    func makeAThumbsUp(at location: CGPoint) {
        model.makeAThumbsUp(x: location.x, y: location.y)
    }
    
}
