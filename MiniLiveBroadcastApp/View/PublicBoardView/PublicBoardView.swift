//
//  PublicBoardView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/14.
//

import SwiftUI

struct PublicBoardView: View {
    
    @ObservedObject var model:PublicBoardViewModel
    let textFieldModel:AutoFitTextFieldViewModel
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            AutoFitTextFieldView(model: textFieldModel)
        }
    }
}

struct PublicBoardView_Previews: PreviewProvider {
    static var previews: some View {
        PublicBoardView(
            model: PublicBoardViewModel(),
            textFieldModel: AutoFitTextFieldViewModel())
    }
}
