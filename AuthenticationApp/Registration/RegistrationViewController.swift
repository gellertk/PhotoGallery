//
//  RegistratinViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

//import UIKit

//class RegistrationViewController: UIViewController {
//    
//    private lazy var registrationView: RegistrationView = {
//        let view = RegistrationView()
//        view.delegate = self
//        
//        return view
//    }()
//    
//    override func loadView() {
//        view = ScrollViewContainer(with: registrationView)
//        addCloseBarButton()
//    }
//    
//}
//
//extension RegistrationViewController: RegistrationViewDelegate {
//    
//    func didTapSignUpButton() {
//    
//        let propertiesAndValues =
//        registrationView.registrationFieldsStackView.getTextFieldsPropertiesAndValues(properties: Constant.Collection.signUpProperties)
//        
//        let login = propertiesAndValues["login"] ?? ""
//  
//        if Database.shared.findUser(login: login) == nil {
//            Database.shared.saveUser(login: login,
//                                     password: propertiesAndValues["password"] ?? "")
//           
//            presentFullScreenViewController(viewController: AuthenticationTabBarController(),
//                                            animate: .flipHorizontal)
//
//            guard let user = Database.shared.findUser(login: login) else {
//                return
//            }
//            
//            Database.shared.saveActiveUser(user: user)
//        } else {
//            registrationView.showError(text: "Пользователь с таким логином уже существует")
//        }
//        
//    }
//    
//}
