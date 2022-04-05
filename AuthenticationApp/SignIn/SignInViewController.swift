//
//  ViewController.swift
//  signInApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

class SignInViewController: UIViewController {
    
    private lazy var signInView: SignInView = {
        let view = SignInView()
        view.signInViewControllerDelegate = self
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

private extension SignInViewController {
    
    func setupView() {
        [signInView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            signInView.topAnchor.constraint(equalTo: view.topAnchor),
            signInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signInView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signInView.switchBasedNextTextField(textField)
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        signInView.textFieldDidBeginEditing(textField.tag)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
    
        signInView.setupSignInButton(editedTextFieldIsEmpty: updatedString.isEmpty,
                                             editedTextFieldTag: textField.tag)
        
        return true
    }
    
    //TODO: deleting password action
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        signInView.setupSignInButton(editedTextFieldIsEmpty: true,
                                             editedTextFieldTag: textField.tag)
        
        return true
    }
    
}
