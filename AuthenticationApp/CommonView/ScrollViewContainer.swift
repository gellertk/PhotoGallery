//
//  ScrollViewContainer.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class ScrollViewContainer: UIView {

    // MARK: - Properties
    public let scrollView: UIScrollView = {

        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.indicatorStyle = .white
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    private var view: UIView?

    lazy var keyboardService: KeyboardService = {
        let service = KeyboardService(container: self)
        
        return service
    }()

    // MARK: - Initialization
    convenience init(with view: UIView) {
        self.init()

        self.view = view
        setupConstraints(with: view)
        keyboardService.setupKeyboard()
        backgroundColor = Constant.Color.primary
    }

    // MARK: - Module function
    private func setupConstraints(with view: UIView) {

        addSubviews([scrollView])
        scrollView.addSubviews([view])

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            view.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            view.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        ])
     }
}
