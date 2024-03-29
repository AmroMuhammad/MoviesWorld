//
//  String+Extension.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//

import Foundation

extension String {
    var localize: String {
        let value = NSLocalizedString(self, comment: "")
        return value
    }
}
