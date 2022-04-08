//
//  UIImageView+Extension.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 07.04.2022.
//

import UIKit
import Photos

extension UIImageView {
    
    func fetchImageAsset(_ asset: PHAsset?,
                         targetSize size: CGSize,
                         contentMode: PHImageContentMode = .aspectFill,
                         options: PHImageRequestOptions? = nil,
                         completionHandler: ((Bool) -> Void)?) {
        
        guard let asset = asset else {
            return
        }
        
        let resultHandler: (UIImage?, [AnyHashable: Any]?) -> Void = {[weak self] image, info in
            self?.image = image
        }
        
        PHImageManager.default().requestImage(
               for: asset,
               targetSize: size,
               contentMode: contentMode,
               options: options,
               resultHandler: resultHandler)
    }
    
}
