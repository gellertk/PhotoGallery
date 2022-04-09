//
//  PhotoViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 07.04.2022.
//

import UIKit
import Photos
import CoreImage

protocol PhotoViewControllerDelegate: AnyObject {
    
}

class PhotoViewController: UIViewController {
    
    private var centerCell: FilterCollectionViewCell?
    
    private var currentPhotoIndexPath = IndexPath()
    private var assets: PHFetchResult<PHAsset>
    
    private var context: CIContext?
    private var currentCell: PhotoCollectionViewCell?
    private var currentFilter: CIFilter?
    private var intensity: Float = 0.0
    
    private var isFilterMode = false {
        didSet {
            if isFilterMode {
                navigationItem.rightBarButtonItem?.title = "Закончить правку"
            } else {
                navigationItem.rightBarButtonItem?.title = "Править"
            }
            filterView.isHidden = !isFilterMode
        }
    }
    
    private lazy var photoView: PhotoView = {
        let view = PhotoView(passedContentOffset: currentPhotoIndexPath)
        view.delegate = self
        
        return view
    }()
    
    private lazy var filterView: FilterView = {
        let view = FilterView()
        view.delegate = self

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        context = CIContext()
    }
    
    init(assets: PHFetchResult<PHAsset>, passedContentOffset: IndexPath) {
        self.assets = assets
        self.currentPhotoIndexPath = passedContentOffset
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let layoutMargins = filterView.filterCollectionView.layoutMargins.left + filterView.filterCollectionView.layoutMargins.right
        let sideInset = (view.frame.width / 2) - layoutMargins
        filterView.filterCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                                    left: sideInset,
                                                                    bottom: 0,
                                                                    right: sideInset)
    }
    
}

extension PhotoViewController: FilterViewDelegate {
    
    func didSliderValueChange(value: Float) {
        intensity = value
        applyProcessing()
    }
    
}

extension PhotoViewController: PhotoViewDelegate {
    
}

private extension PhotoViewController {
    
    func setupView() {
        addChoosePhotoBarButton()
        tabBarController?.tabBar.isHidden = true
        view.addSubviews([photoView,
                         filterView])
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            photoView.topAnchor.constraint(equalTo: view.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            filterView.topAnchor.constraint(equalTo: photoView.bottomAnchor),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filterView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func addChoosePhotoBarButton() {
        let filterButton = UIBarButtonItem(title: "Править",
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapFilterButton))
        filterButton.customView?.layer.cornerRadius = filterButton.width / 2
        filterButton.tintColor = Constant.Color.secondary
        navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc func didTapFilterButton() {
        isFilterMode.toggle()
    }
    
    func applyProcessing() {
        
        guard let inputKeys = currentFilter?.inputKeys else {
            return
        }
            
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter?.setValue(intensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter?.setValue(intensity * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter?.setValue(intensity * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter?.setValue(CIVector(x: currentCell?.photoImageView.image?.size.width ?? 0 / 2,
                                             y: currentCell?.photoImageView.image?.size.height ?? 0 / 2), forKey: kCIInputCenterKey)
        }
        
        guard let outputImage = currentFilter?.outputImage else {
            return
        }
        
        if let cgImage = context?.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            currentCell?.photoImageView.image = processedImage
        }
    }
    
    func setFilter(name: String) {
        guard let image = currentCell?.photoImageView.image else {
            return
        }
        currentFilter = CIFilter(name: name)
        
        let beginImage = CIImage(image: image)
        currentFilter?.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            
            return assets.count
        } else {
            
            return Constant.Collection.ciFilters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseId,
                                                                for: indexPath) as? PhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.photoImageView.fetchImageAsset(assets[indexPath.row], targetSize: view.bounds.size, completionHandler: nil)
            currentCell = cell
            //setFilter(name: currentFilter?.name ?? "")
            //setFilter(name: filterNameAndImage.key)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseId,
                                                                for: indexPath) as? FilterCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.layer.cornerRadius = cell.frame.width / 2
            
            let filterNameAndImage = Constant.Collection.ciFilters[indexPath.row]
            cell.setupContent(filterImage: filterNameAndImage.value ?? UIImage())
            //setFilter(name: filterNameAndImage.key)
            
            return cell
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView is UICollectionView else {
            return
        }
        
        let centerPoint = CGPoint(x: filterView.filterCollectionView.frame.size.width / 2 + scrollView.contentOffset.x,
                                  y: filterView.filterCollectionView.frame.size.height / 2 + scrollView.contentOffset.y)
        
        if let indexPath = filterView.filterCollectionView.indexPathForItem(at: centerPoint) {
            setFilter(name: Constant.Collection.ciFilters[indexPath.row].key)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UICollectionView, scrollView.tag != 1 else {
            return
        }
        
        let centerPoint = CGPoint(x: filterView.filterCollectionView.frame.size.width / 2 + scrollView.contentOffset.x,
                                  y: filterView.filterCollectionView.frame.size.height / 2 + scrollView.contentOffset.y)
        
        if let indexPath = filterView.filterCollectionView.indexPathForItem(at: centerPoint), centerCell == nil {
            guard let centerCell = (filterView.filterCollectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell) else {
                return
            }
            self.centerCell = centerCell
            centerCell.transformToBordered()
            //setFilter(name: Constant.Collection.ciFilters[indexPath.row].key)
        }
        
        if let cell = centerCell {
            let offsetX = centerPoint.x - cell.center.x
            if offsetX < -15 || offsetX > 15 {
                centerCell?.transformToStandart()
                centerCell = nil
            }
        }
        
    }
    
}
