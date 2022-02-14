//
//  PublicBoardView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/14.
//

import SwiftUI

struct PublicBoardView: View {
    
    @ObservedObject var model:PublicBoardViewModel
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            TextField(String.PublicBoardTextFieldHint,text: $model.edittingText)
            
        }
        .background(Color.clear)
        
    }
}

struct PublicBoardView_Previews: PreviewProvider {
    static var previews: some View {
        PublicBoardView(model: PublicBoardViewModel())
    }
}
