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
            photosCollectionView.delegate = delegate as? UICollectionViewDelegate
            photosCollectionView.dataSource = delegate as? UICollectionViewDataSource
        }
    }
    
    private let photosCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        
        return flowLayout
    }()
    
    public lazy var photosCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: photosCollectionViewFlowLayout)
        collectionView.register(PhotosCollectionViewCell.self,
                                forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //photosCollectionView.collectionViewLayout.invalidateLayout()
        //photosCollectionViewFlowLayout.itemSize = CGSize(width: frame.width / 3 - 1,
                                                        //height: frame.width / 3 - 1)
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
