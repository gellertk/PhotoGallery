//
//  UserListTableViewCell.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.Color.secondary
        
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Constant.Color.secondary
        //label.textColor = Constant.Color.secondary
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constant.String.userListTableViewCellId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = Constant.Numeric.defaultCornerRadius
        layer.cornerRadius = Constant.Numeric.defaultCornerRadius
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
}

private extension UserListTableViewCell {
    
    func setupView() {
        backgroundColor = .darkGray
        selectionStyle = .none
        [loginLabel,
         avatarImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            loginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            loginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            loginLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            avatarImageView.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
}

extension UserListTableViewCell {
    
    func setup(login: String, imageData: Data) {
        loginLabel.text = login
    }
    
}
