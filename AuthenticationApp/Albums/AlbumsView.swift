//
//  AlbumView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 07.04.2022.
//

import UIKit

protocol AlbumsViewDelegate: AnyObject {
    
}

class AlbumsView: UIView {
    
    weak var delegate: AlbumsViewDelegate? {
        didSet {
            albumsCollectionView.delegate = delegate as? UICollectionViewDelegate
            albumsCollectionView.dataSource = delegate as? UICollectionViewDataSource
        }
    }
    
    private let albumsCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        
        return flowLayout
    }()
    
    lazy var albumsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: albumsCollectionViewFlowLayout)
        collectionView.register(AlbumsCollectionViewCell.self,
                                forCellWithReuseIdentifier: RegisterIdentifiers.albumsCollectionViewCellId.rawValue)
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

private extension AlbumsView {
    
    func setupView() {
        backgroundColor = Constant.Color.primary
        addSubviews([albumsCollectionView])
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            albumsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            albumsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            albumsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
    }
    
}
