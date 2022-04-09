//
//  KeyboardService.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class KeyboardService {

    weak private var view: ScrollViewContainer?

    init(container: ScrollViewContainer) {
        self.view = container
    }

    public func setupKeyboard() {

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view?.addGestureRecognizer(tapGesture)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc func endEditing() {
        view?.endEditing(true)
    }

    @objc func keyboardWillChangeFrame(_ notification: NSNotification) {

        let userInfo = notification.userInfo
        guard let keyboardFrameInWindow = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let keyboardFrameInView = view?.convert(keyboardFrameInWindow, from: view?.window)

        var contentInset = view?.scrollView.contentInset
        contentInset?.bottom = keyboardFrameInView?.height ?? 0

        view?.scrollView.contentInset = contentInset ?? .zero
    }

    @objc func keyboardWillHide() {
        view?.scrollView.contentInset = .zero
    }
}
