//
//  PhotoGalleryView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class PhotosView: UIView {
    
    weak var delegate: PhotosViewController? {
        didSet {
            photosCollectionView.delegate = delegate
            photosCollectionView.dataSource = delegate
        }
    }
    
    private let photosCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        
        return flowLayout
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: photosCollectionViewFlowLayout)
        collectionView.register(PhotosCollectionViewCell.self,
                                forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseId)
        collectionView.backgroundColor = Constant.Color.primary
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PhotosView {
    
    func setupView() {
        backgroundColor = Constant.Color.primary
        addSubviews([photosCollectionView])
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
    }
    
}
