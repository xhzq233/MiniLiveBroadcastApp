//
//  AutoFitTextFieldViewModel.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/15.
//

import Combine
import SwiftUI

protocol AutoFitTextFieldDelegate: AnyObject {
    func onKeyboardWillShow()
    func onKeyboardWillDisappear()
}

class AutoFitTextFieldViewModel: ObservableObject {

    @Published var keyBoardBottomPadding: CGFloat = 0
    weak var delegate: AutoFitTextFieldDelegate?
    var keyboardWillHideNotificationSubscriber: AnyCancellable? = nil
    var keyboardWillShowNotificationSubscriber: AnyCancellable? = nil

    init() {
        keyboardWillHideNotificationSubscriber = NotificationCenter.Publisher(
            center: .default,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        ).sink { [unowned self] _ in
            delegate?.onKeyboardWillDisappear()
            withAnimation {
                keyBoardBottomPadding = 0
            }
        }

        keyboardWillShowNotificationSubscriber = NotificationCenter.Publisher(
            center: .default,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        ).sink { [unowned self] notification in
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
    }

    deinit {
        keyboardWillHideNotificationSubscriber?.cancel()
        keyboardWillShowNotificationSubscriber?.cancel()
    }
}
