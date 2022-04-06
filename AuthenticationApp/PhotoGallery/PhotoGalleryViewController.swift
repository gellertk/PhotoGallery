//
//  PhotoGalleryViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    
    override func loadView() {
        let view = PhotoGalleryView()
        view.delegate = self
        self.view = view
        setupNavigationBar()
    }
    
}

private extension PhotoGalleryViewController {
    
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        addChoosePhotoBarButton()
        addExitBarButton()
    }
    
}

extension PhotoGalleryViewController: PhotoGalleryViewDelegate {
    
}
