//
//  PhotoGalleryViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit
import Photos

class AlbumsViewController: UIViewController {
    
    private var sections: [AlbumCollectionSectionType] = [.all,
                                                          .smartAlbums,
                                                          .userCollections]
    private var allPhotos = PHFetchResult<PHAsset>()
    private var smartAlbums = PHFetchResult<PHAssetCollection>()
    private var userCollections = PHFetchResult<PHAssetCollection>()
    
    private let albumsView = AlbumsView()
    
    override func loadView() {
        startFetchingAssets()
        let view = albumsView
        view.delegate = self
        self.view = view
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
}

extension AlbumsViewController {
    
    func startFetchingAssets() {
        getPermissionIfNecessary { granted in
            guard granted else {
                return
            }
            self.fetchAssets()
            DispatchQueue.main.async {
                self.albumsView.albumsCollectionView.reloadData()
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
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        smartAlbums = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .albumRegular,
            options: nil)
        userCollections = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .albumRegular,
            options: nil)
    }
    
}

extension AlbumsViewController: AlbumsViewDelegate {
    
}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterIdentifiers.albumsCollectionViewCellId.rawValue,
                                                            for: indexPath) as? AlbumsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        var coverAsset: PHAsset?
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .all:
            coverAsset = allPhotos.firstObject
            cell.setupContent(title: sectionType.description)
        case .smartAlbums, .userCollections:
            let collection = (sectionType == .smartAlbums ? smartAlbums[indexPath.item] : userCollections[indexPath.item])
            let fetchedAssets = PHAsset.fetchAssets(in: collection, options: nil)
            coverAsset = fetchedAssets.firstObject
            cell.setupContent(title: collection.localizedTitle)
        }
        
        guard let asset = coverAsset else {
            return cell
        }
        
        cell.albumImageView.fetchImageAsset(asset, targetSize: cell.bounds.size, completionHandler: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sectionType = sections[indexPath.section]
        let item = indexPath.item
        
        let assets: PHFetchResult<PHAsset>
        let title: String
        
        switch sectionType {
        case .all:
            assets = allPhotos
            title = AlbumCollectionSectionType.all.description
        case .smartAlbums, .userCollections:
            let album =
            sectionType == .smartAlbums ? smartAlbums[item] : userCollections[item]
            assets = PHAsset.fetchAssets(in: album, options: nil)
            title = album.localizedTitle ?? ""
        }
        
        return PhotosCollectionViewController(assets: assets, title: title)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch sections[section] {
        case .all:
            
            return 1
        case .smartAlbums:
            
            return smartAlbums.count
        case .userCollections:
            
            return userCollections.count
        }
        
    }
    
}

extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CollectionViewFlowLayoutType(.album, frame: view.frame).sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return CollectionViewFlowLayoutType(.album, frame: view.frame).sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CollectionViewFlowLayoutType(.album, frame: view.frame).sectionInsets.left
    }
    
}

extension AlbumsViewController: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.sync {
            if let changeDetails = changeInstance.changeDetails(for: allPhotos) {
                allPhotos = changeDetails.fetchResultAfterChanges
            }
            if let changeDetails = changeInstance.changeDetails(for: smartAlbums) {
                smartAlbums = changeDetails.fetchResultAfterChanges
            }
            if let changeDetails = changeInstance.changeDetails(for: userCollections) {
                userCollections = changeDetails.fetchResultAfterChanges
            }
            albumsView.albumsCollectionView.reloadData()
        }
    }
    
}

