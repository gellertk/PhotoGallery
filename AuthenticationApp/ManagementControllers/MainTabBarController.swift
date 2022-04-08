//
//  AuthenticationTabBarController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    private func setup() {
        
        setViewControllers([
            MainNavigationController(rootViewController: AlbumsViewController()) ,
            MainNavigationController(rootViewController: UserListViewController())
        ], animated: true)
        
        if let items = tabBar.items {
            
            let titlesAndImages: KeyValuePairs = [
                "Галерея фото": UIImage(systemName: "photo.on.rectangle.angled") ?? UIImage(),
                "Список пользователей": UIImage(systemName: "person.fill") ?? UIImage(),
            ]
            
            for index in titlesAndImages.indices {
                items[index].title = titlesAndImages[index].key
                items[index].image = titlesAndImages[index].value
            }
            
            tabBar.unselectedItemTintColor = Constant.Color.disabledSecondary
            tabBar.tintColor = Constant.Color.secondary
            tabBar.isTranslucent = false
            tabBar.barTintColor = .black
        }
        
        addExitBarButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
