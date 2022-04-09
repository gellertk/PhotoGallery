//
//  UserListViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class UserListViewController: UIViewController {
    
    private let userListView = UserListView()
    
    override func loadView() {
        let view = userListView
        view.delegate = self
        self.view = view
        navigationController?.navigationBar.barTintColor = Constant.Color.primary
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userListView.usersTableView.reloadData()
    }

}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Database.shared.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.reuseId) as? UserListTableViewCell else {
            return UITableViewCell()
        }
                
        let user = Database.shared.users[indexPath.row]
        var image = UIImage(systemName: "person") ?? UIImage()
        if let url = user.avatarURL, let savedImage = UIImage(url: url) {
            image = savedImage
        }
       
        cell.setupContent(login: user.login, image: image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constant.Numeric.defaultUIElementHeight * 1.5
    }
    
}
