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
        current.view.frame = view.bounds              // 2
        view.addSubview(current.view)                 // 3
        current.didMove(toParent: self) //
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
        addChild(new)                    // 2
        new.view.frame = view.bounds                   // 3
        view.addSubview(new.view)                      // 4
        new.didMove(toParent: self)      // 5
        current.willMove(toParent: nil)  // 6
        current.view.removeFromSuperview()         // 7
        current.removeFromParent()       // 8
        current = new                                  // 9
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
