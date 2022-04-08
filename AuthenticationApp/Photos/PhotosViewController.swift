//
//  PhotoGalleryViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit
import Photos

class PhotosViewController: UIViewController {
    
    private var isSelectionMode = false {
        didSet {
            if isSelectionMode {
                navigationItem.rightBarButtonItem?.title = "Закончить выбор"
            } else {
                navigationItem.rightBarButtonItem?.title = "Выбрать аватар"
            }
            tabBarController?.tabBar.isHidden = isSelectionMode
        }
    }
    private let photosView = PhotosView()
    private var assets: PHFetchResult<PHAsset>
    
    init(assets: PHFetchResult<PHAsset>, title: String) {
        self.assets = assets
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
        addChoosePhotoBarButton()
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    override func loadView() {
        let view = photosView
        view.delegate = self
        self.view = view
    }
    
    func addChoosePhotoBarButton() {
        let choosePhotoBarButton = UIBarButtonItem(title: "Выбрать аватар",
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(didTapChoosePhotoBarButton))
        choosePhotoBarButton.customView?.layer.cornerRadius =  choosePhotoBarButton.width / 2
        choosePhotoBarButton.customView?.backgroundColor = .darkGray
        choosePhotoBarButton.tintColor = Constant.Color.secondary
        navigationItem.rightBarButtonItem = choosePhotoBarButton
    }
    
    @objc func didTapChoosePhotoBarButton() {
        isSelectionMode.toggle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            isSelectionMode = false
        }
    }
    
}

extension PhotosViewController: PhotosViewDelegate {
    
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isSelectionMode {
            guard let cell = collectionView.cellForItem(at: indexPath) as? PhotosCollectionViewCell,
            let data = cell.photoImageView.image?.pngData() else {
                return
            }
            
            Database.shared.saveAvatarURL(data: data)
            isSelectionMode.toggle()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.photoImageView.fetchImageAsset(self.assets[indexPath.item],
                                            targetSize: CGSize(width: 500,
                                                               height: 500),
                                            completionHandler: nil)
        
        return cell
    }
    
}

extension PhotosViewController: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let change = changeInstance.changeDetails(for: assets) else {
            return
        }
        DispatchQueue.main.sync {
            assets = change.fetchResultAfterChanges
            photosView.photosCollectionView.reloadData()
        }
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CollectionViewFlowLayoutType(.photos, frame: view.frame).sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return CollectionViewFlowLayoutType(.photos, frame: view.frame).sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CollectionViewFlowLayoutType(.photos, frame: view.frame).sectionInsets.left
    }
}
