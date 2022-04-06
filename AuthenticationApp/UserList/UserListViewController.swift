//
//  UserListViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class UserListViewController: UIViewController {
    
    override func loadView() {
        let view = UserListView()
        view.delegate = self
        self.view = view
        setupNavigationBar()
    }
    
}

private extension UserListViewController {
    
    func setupNavigationBar() {
        addExitBarButton()
    }
    
}

extension UserListViewController: UserListViewDelegate {
    
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Database.shared.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.String.userListTableViewCellId) as? UserListTableViewCell else {
            
            return UITableViewCell()
        }
        
        let user = Database.shared.users[indexPath.row]
        
        cell.setup(login: user.login, imageData: user.avatar)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constant.Numeric.defaultUIElementHeight * 2
    }
    
}
