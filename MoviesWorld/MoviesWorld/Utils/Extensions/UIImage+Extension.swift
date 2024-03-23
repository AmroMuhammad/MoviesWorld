//
//  UIImage+Extension.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//

import UIKit

extension UIImage {
    static var emptyImage: UIImage {
        return UIImage()
    }
    
    static var showIcon: UIImage {
        return UIImage(systemName: "eye") ?? .emptyImage
    }
    
    static var hideICon: UIImage {
        return UIImage(systemName: "eye.slash") ?? .emptyImage
    }
}
