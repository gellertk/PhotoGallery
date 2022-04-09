//
//  AlbumView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 07.04.2022.
//

import UIKit

class AlbumsView: UIView {
    
    weak var delegate: AlbumsViewController? {
        didSet {
            albumsCollectionView.delegate = delegate
            albumsCollectionView.dataSource = delegate
        }
    }
    
    private let albumsCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        
        return flowLayout
    }()
    
    lazy var albumsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: albumsCollectionViewFlowLayout)
        collectionView.register(AlbumsCollectionViewCell.self,
                                forCellWithReuseIdentifier: AlbumsCollectionViewCell.reuseId)
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
//        albumsCollectionViewFlowLayout.itemSize = CGSize(width: frame.width / 2 - 1,
//                                                        height: frame.width / 2 - 1)
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
