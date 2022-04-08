//
//  UserListTableViewCell.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "userListTableViewCellId"

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.Color.secondary
        
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Constant.Color.secondary
        imageView.contentMode = .scaleAspectFill
        //imageView.backgroundColor = .darkGray
        //label.textColor = Constant.Color.secondary
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: UserListTableViewCell.reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = frame.width / 2

//        contentView.layer.cornerRadius = Constant.Numeric.defaultCornerRadius
//        layer.cornerRadius = Constant.Numeric.defaultCornerRadius
        //avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        //avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
}

private extension UserListTableViewCell {
    
    func setupView() {
        preservesSuperviewLayoutMargins = false
        separatorInset = .zero
        layoutMargins = .zero
        backgroundColor = Constant.Color.primary
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
