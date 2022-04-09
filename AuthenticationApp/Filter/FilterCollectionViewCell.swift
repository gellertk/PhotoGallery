//
//  FilterCollectionViewCell.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 09.04.2022.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    static let reuseId = "filterCollectionViewCellId"

    let filterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        filterImageView.image = nil
    }
    
    func setupContent(filterImage: UIImage) {
        filterImageView.image = filterImage
    }
    
    func transformToBordered() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layer.borderColor = UIColor.lightGray.cgColor
            self?.layer.borderWidth = 1.3
        }
    }
    
    func transformToStandart() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layer.borderWidth = 0
        }
    }
    
}

private extension FilterCollectionViewCell {
    
    func setupView() {
        contentView.addSubviews([filterImageView])
        setupConstraint()
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            filterImageView.topAnchor.constraint(equalTo: topAnchor),
            filterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            filterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
