//
//  PhotoGalleryViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit
import Photos

class PhotosViewController: UIViewController {
    
    var assets: PHFetchResult<PHAsset>

    init?(assets: PHFetchResult<PHAsset>) {
      self.assets = assets
      super.init(coder: coder)
      self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      PHPhotoLibrary.shared().register(self)
    }

    deinit {
      PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
        
    private let photosView = PhotosView()
    
    override func loadView() {
        let view = photosView
        view.delegate = self
        self.view = view
    }
    
}

extension PhotosViewController {
    
    func startFetchingAssets() {
        getPermissionIfNecessary { granted in
            guard granted else {
                return
            }
            self.fetchAssets()
            DispatchQueue.main.async {
                self.photosView.photoCollectionView.reloadData()
            }
        }
        PHPhotoLibrary.shared().register(self)
    }
    
    func getPermissionIfNecessary(completionHandler: @escaping (Bool) -> Void) {
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            completionHandler(true)
            return
        }
        
        PHPhotoLibrary.requestAuthorization { status in
            completionHandler(status == .authorized ? true : false)
        }
    }
    
    func fetchAssets() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
            NSSortDescriptor(
                key: "creationDate",
                ascending: false)
        ]
        // 2
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        // 3
        //        smartAlbums = PHAssetCollection.fetchAssetCollections(
        //            with: .smartAlbum,
        //            subtype: .albumRegular,
        //            options: nil)
        //        // 4
        //        userCollections = PHAssetCollection.fetchAssetCollections(
        //            with: .album,
        //            subtype: .albumRegular,
        //            options: nil)
    }
    
    
    
}

extension PhotosViewController: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.sync {
            // 1
            if let changeDetails = changeInstance.changeDetails(for: allPhotos) {
                allPhotos = changeDetails.fetchResultAfterChanges
            }
            // 2
            //      if let changeDetails = changeInstance.changeDetails(for: smartAlbums) {
            //        smartAlbums = changeDetails.fetchResultAfterChanges
            //      }
            //      if let changeDetails = changeInstance.changeDetails(for: userCollections) {
            //        userCollections = changeDetails.fetchResultAfterChanges
            //      }
            // 4
            photoView.photoCollectionView.reloadData()
        }
    }
    
}

extension PhotosViewController: PhotosViewDelegate {
    
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterIdentifiers.photoCollectionViewCellId.rawValue,
                                                            for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupContent(image: UIImage(systemName: "pencil") ?? UIImage())
        
        return cell
    }
    
}
