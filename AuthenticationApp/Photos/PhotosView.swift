//
//  PhotoGalleryView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

protocol PhotosViewDelegate: AnyObject {
    
}

class PhotosView: UIView {
    
    public weak var delegate: PhotosViewDelegate? {
        didSet {
            photoCollectionView.delegate = delegate as? UICollectionViewDelegate
            photoCollectionView.dataSource = delegate as? UICollectionViewDataSource
        }
    }
    
    private let photoCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        
        return flowLayout
    }()
    
    public lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: photoCollectionViewFlowLayout)
        collectionView.register(PhotosCollectionViewCell.self,
                                forCellWithReuseIdentifier: RegisterIdentifiers.photoCollectionViewCellId.rawValue)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoCollectionViewFlowLayout.itemSize = CGSize(width: frame.size.width / 4 - 1,
                                                        height: frame.size.width / 4 - 1)
    }
    
}

private extension PhotosView {
    
    func setupView() {
        addSubviews([photoCollectionView])
        setupConstraints()
        backgroundColor = Constant.Color.primary
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
    }
    
}
