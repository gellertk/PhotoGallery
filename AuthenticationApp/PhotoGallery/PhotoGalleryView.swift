//
//  PhotoGalleryView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

protocol PhotoGalleryViewDelegate: AnyObject {
    
}

class PhotoGalleryView: UIView {
    
    public weak var delegate: PhotoGalleryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PhotoGalleryView {
    
    func setupView() {
//        [
////        registrationFieldsStackView,
////         signUpButton
//        ].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            addSubview($0)
//        }
//        setupConstraints()
        backgroundColor = Constant.Color.primary
    }
    
    func setupConstraints() {
        
    }

}
