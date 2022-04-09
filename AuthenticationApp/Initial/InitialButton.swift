//
//  InitialButton.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 09.04.2022.
//

import UIKit

class InitialButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension InitialButton {
    
    func setupView() {
        backgroundColor = Constant.Color.primary
        setTitleColor(Constant.Color.secondary, for: .normal)
        setTitleColor(Constant.Color.disabledSecondary, for: .highlighted)
    }
    
}
