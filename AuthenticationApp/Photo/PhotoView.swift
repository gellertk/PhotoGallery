//
//  PhotoView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 07.04.2022.
//

import UIKit

protocol PhotoViewDelegate: AnyObject {
    
}

class PhotoView: UIView {
    
    private var passedContentOffset = IndexPath()
    
    weak var delegate: PhotoViewDelegate? {
        didSet {
            photoCollectionView.delegate = delegate as? UICollectionViewDelegate
            photoCollectionView.dataSource = delegate as? UICollectionViewDataSource
        }
    }
    
    private let photoCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .zero
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }()
    
    private(set) lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: photoCollectionViewFlowLayout)
        collectionView.register(PhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseId)
        collectionView.backgroundColor = Constant.Color.primary
        collectionView.isPagingEnabled = true
        collectionView.tag = 1
        
        return collectionView
    }()
    
    init(passedContentOffset: IndexPath) {
        self.passedContentOffset = passedContentOffset
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoCollectionViewFlowLayout.itemSize = photoCollectionView.frame.size
        photoCollectionView.scrollToItem(at: passedContentOffset, at: .left, animated: false)
    }
    
}

private extension PhotoView {
    
    func setupView() {
        backgroundColor = Constant.Color.primary
        addSubviews([photoCollectionView])
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: topAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
        
    }
    
}
