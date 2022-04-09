//
//  UserListTableViewCell.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    static let reuseId = "userListTableViewCellId"

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.Color.secondary
        
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Constant.Color.primary
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: UserListTableViewCell.reuseId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension UserListTableViewCell {
    
    func setupView() {
        backgroundColor = Constant.Color.primary
        preservesSuperviewLayoutMargins = false
        separatorInset = .zero
        layoutMargins = .zero
        selectionStyle = .none
        contentView.addSubviews([loginLabel,
                                 avatarImageView])
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            loginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            loginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            loginLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            avatarImageView.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight - 5),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight - 5)
        ])
    }
    
}

extension UserListTableViewCell {
    
    func setupContent(login: String, image: UIImage) {
        loginLabel.text = login
        avatarImageView.image = image
    }
    
}
