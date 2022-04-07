//
//  PhotoCollectionViewCell.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 07.04.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent(image: UIImage) {
        photoImageView.image = image
    }
    
}

private extension PhotosCollectionViewCell {
    
    func setupView() {
        contentView.backgroundColor = .lightGray
        contentView.addSubviews([photoImageView])
        setupConstraint()
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
