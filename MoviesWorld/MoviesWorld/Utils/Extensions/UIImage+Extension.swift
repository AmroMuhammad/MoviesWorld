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
    
    static var backButton: UIImage {
        return UIImage(systemName: "chevron.backward.circle") ?? .emptyImage
    }
}
