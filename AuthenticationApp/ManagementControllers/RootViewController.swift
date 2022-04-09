//
//  RootViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 07.04.2022.
//

import UIKit

class RootViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private var current: UIViewController
    
    init() {
        self.current = MainNavigationController(rootViewController: InitialViewController())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    func showLoginScreen() {
        let new = UINavigationController(rootViewController: InitialViewController())
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    func switchToMainScreen() {
        let mainViewController = MainTabBarController()
        mainViewController.modalPresentationStyle = .fullScreen
        let mainScreen = MainNavigationController(rootViewController: mainViewController)
        mainScreen.modalPresentationStyle = .overFullScreen
        animateFadeTransition(to: mainScreen)
    }
    
    func switchToLogout() {
        let loginViewController = InitialViewController()
        let logoutScreen = MainNavigationController(rootViewController: loginViewController)
        animateDismissTransition(to: logoutScreen)
    }
    
}
