//
//  PhotoCollectionViewCell.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 09.04.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "photoCollectionViewCellId"
    
    private weak var delegate: PhotoViewController?
    
    private lazy var photoScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.flashScrollIndicators()
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
            
        return scrollView
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTapGestureRecognizer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoScrollView.frame = bounds
        photoImageView.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoScrollView.setZoomScale(1, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PhotoCollectionViewCell {
    
    func setupView() {
        addSubviews([photoScrollView])
        photoScrollView.addSubviews([photoImageView])
    }
    
    func setupTapGestureRecognizer() {
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapPhotoScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        photoScrollView.addGestureRecognizer(doubleTapGest)
    }
    
    @objc func didDoubleTapPhotoScrollView(recognizer: UITapGestureRecognizer) {
        if photoScrollView.zoomScale == 1 {
            photoScrollView.zoom(to: zoomRectForScale(scale: photoScrollView.maximumZoomScale,
                                                      center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            photoScrollView.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = photoImageView.frame.size.height / scale
        zoomRect.size.width  = photoImageView.frame.size.width  / scale
        let newCenter = photoImageView.convert(center, from: photoImageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
}

extension PhotoCollectionViewCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
}


