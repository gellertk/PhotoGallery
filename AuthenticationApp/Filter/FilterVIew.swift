//
//  PhotoView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 07.04.2022.
//

import UIKit

protocol FilterViewDelegate: AnyObject {
    func didSliderValueChange(value: Float)
}

class FilterView: UIView {
        
    weak var delegate: FilterViewDelegate? {
        didSet {
            filterCollectionView.delegate = delegate as? UICollectionViewDelegate
            filterCollectionView.dataSource = delegate as? UICollectionViewDataSource
        }
    }
    
    private let filterCollectionViewFlowLayout = FilterCollectionViewFlowLayout()
    
    private(set) lazy var filterCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: filterCollectionViewFlowLayout)
        collectionView.register(FilterCollectionViewCell.self,
                                forCellWithReuseIdentifier: FilterCollectionViewCell.reuseId)
        collectionView.backgroundColor = Constant.Color.primary
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = Constant.Color.primary
        
        return collectionView
    }()
    
    private let filterSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSliderValueChange), for: .valueChanged)
        
        return slider
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
 
    }
    
}

private extension FilterView {
    
    func setupView() {
        isHidden = true
        addSubviews([filterCollectionView, filterSlider])
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            filterSlider.topAnchor.constraint(equalTo: topAnchor),
            filterSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filterCollectionView.topAnchor.constraint(equalTo: filterSlider.bottomAnchor),
            filterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    @objc func didSliderValueChange(_ sender: UISlider) {
        delegate?.didSliderValueChange(value: sender.value)
    }
    
}
