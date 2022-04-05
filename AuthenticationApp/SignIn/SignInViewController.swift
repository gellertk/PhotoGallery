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
        setupNavigationBar()
    }
    
    func setupConstraints() {
        view.makeSubviewConstraintsEqualToEdges(view: signInView)
    }
    
    func setupNavigationBar() {
        let closeBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(didTapCloseBarButton))
        closeBarButton.tintColor = .white
        navigationItem.leftBarButtonItem = closeBarButton
    }
    
    @objc func didTapCloseBarButton() {
        dismiss(animated: true)
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signInView.makeNextResponder(textField: textField)
        
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
