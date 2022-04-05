//
//  RegistratinViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

class RegistrationViewController: UIViewController {

    private lazy var registrationView: RegistrationView = {
        let view = RegistrationView()
        view.registrationViewController = self

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

private extension RegistrationViewController {
    
    func setupView() {
        [registrationView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        view.makeSubviewConstraintsEqualToEdges(view: registrationView)
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    
    
    
}
