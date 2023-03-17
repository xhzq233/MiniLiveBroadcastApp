//
//  AutoFitTextFieldView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/15.
//

import SwiftUI

//using binding can change it to any value
typealias ReturnCallBack = (_ content: Binding<String>) -> Void

struct AutoFitTextFieldView: View {

    @ObservedObject var model: AutoFitTextFieldViewModel
    let returnCallBack: ReturnCallBack
    @State var edittingText: String = ""

    var body: some View {
        ZStack(alignment: .trailing) {
            let extractedExpr = TextField(String.PublicBoardTextFieldHint, text: $edittingText)
            extractedExpr
                .onSubmit {
                    returnCallBack($edittingText)
                }
                .thinBlurBackground()
            Image(systemName: "mic.fill")
                .imageScale(.large)
                .padding()
        }
        .offset(x: 0, y: -model.keyBoardBottomPadding)
    }
}
