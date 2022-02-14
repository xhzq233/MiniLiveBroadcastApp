//
//  ThumbsUpView.swift
//  MiniLiveBroadcastApp
//
//  Created by Maihao on 2022/2/13.
//

import SwiftUI

struct ThumbsUpView: View {
    
    public let id = UUID()
    
    public var hit: CGPoint = CGPoint()
    
    @State var isAnimation: Bool = false {
        didSet {
            if !isAnimation {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:{
                    withAnimation{
                        isAnimation = false
                    }
                })
            }
        }
    }
    
    var body: some View{
        Image(systemName: "hand.thumbsup")
            .frame(width: 100, height: 100)
            .rotationEffect(Angle(degrees: Double(Int.random(in: -60 ... -30))))
            .scaleEffect(isAnimation ? 2:0)
            .opacity(isAnimation ? 0.6:0)
            .onAppear {
                withAnimation{
                    isAnimation = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    withAnimation {
                        isAnimation = false
                    }
                })
            }
    }
    
}

struct ThumbsUpView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbsUpView()
    }
}
