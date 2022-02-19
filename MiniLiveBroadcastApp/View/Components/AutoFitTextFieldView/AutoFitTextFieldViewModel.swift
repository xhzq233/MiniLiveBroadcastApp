//
//  AutoFitTextFieldViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/15.
//

import SwiftUI

/// # literally delegate
protocol AutoFitTextFieldDelegate: AnyObject {
    func onKeyboardWillShow()
    func onKeyboardWillDisappear()
}

class AutoFitTextFieldViewModel: ObservableObject {

    @Published var keyBoardBottomPadding: CGFloat = 0
    weak var delegate: AutoFitTextFieldDelegate?

    @objc func keyboardWillShow(_ notification: Notification) {
        delegate?.onKeyboardWillShow()
        if let keyboardFrame: NSValue =
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            withAnimation(Animation.easeOut(duration: 0.25)) {
                keyBoardBottomPadding = keyboardHeight
            }
        }
    }

    // return to the original states
    @objc func keyboardWillDisappear(notification: NSNotification?) {
        delegate?.onKeyboardWillDisappear()
        withAnimation {
            keyBoardBottomPadding = 0
        }
    }
}
