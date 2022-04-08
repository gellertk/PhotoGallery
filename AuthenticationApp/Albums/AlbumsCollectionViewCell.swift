//
//  AlbumsCollectionViewCell.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 07.04.2022.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "albumsCollectionViewCellId"
    
    public let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let albumTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.Color.secondary
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent(title: String?) {
        albumTitleLabel.text = title ?? "Без названия"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumTitleLabel.text = "Без названия"
        albumImageView.image = UIImage(systemName: "photo")
    }
    
}

private extension AlbumsCollectionViewCell {
    
    func setupView() {
        contentView.addSubviews([albumImageView,
                                albumTitleLabel])
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            albumTitleLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 10),
            albumTitleLabel.centerXAnchor.constraint(equalTo: albumImageView.centerXAnchor),
        ])
    }
    
}
