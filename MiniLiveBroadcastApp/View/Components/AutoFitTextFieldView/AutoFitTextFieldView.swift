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
            TextField(String.PublicBoardTextFieldHint, text: $edittingText)
                .onSubmit {
                    returnCallBack($edittingText)
                }
                .thinBlurBackground()
            Image(systemName: "mic.fill")
                .imageScale(.large)
                .padding()
        }
        .offset(x: 0, y: -model.keyBoardBottomPadding)
        .onAppear {
            // kvo
            NotificationCenter.default.addObserver(
                model,
                selector: #selector(model.keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
            NotificationCenter.default.addObserver(
                model,
                selector: #selector(model.keyboardWillDisappear),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(
                model,
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
            NotificationCenter.default.removeObserver(
                model,
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
        }
    }
}
