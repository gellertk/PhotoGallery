//
//  UserListView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class UserListView: UIView {
    
    weak var delegate: UserListViewController? {
        didSet {
            usersTableView.delegate = delegate
            usersTableView.dataSource = delegate
        }
    }
    
    lazy var usersTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Constant.Color.primary
        tableView.register(UserListTableViewCell.self,
                           forCellReuseIdentifier: UserListTableViewCell.reuseId)
        tableView.separatorColor = Constant.Color.disabledSecondary
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension UserListView {
    
    func setupView() {
        backgroundColor = Constant.Color.primary
        addSubviews([
            usersTableView
        ])
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: topAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constant.Numeric.defaultBorderConstraint),
            usersTableView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constant.Numeric.defaultBorderConstraint),
            usersTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
}

