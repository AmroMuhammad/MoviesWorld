//
//  Bundle+Extension.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

extension Bundle {
    func value<T>(for key: String) -> T? {
        object(forInfoDictionaryKey: key) as? T
    }
    
    var mixPanelKey: String {
        value(for: "mixPanelKey").orEmpty
    }
    
    var amplitudeKey: String {
        value(for: "amplitudeKey").orEmpty
    }
    
    var segmentKey: String {
        value(for: "segmentKey").orEmpty
    }
}


extension Optional where Wrapped == String {
    var orEmpty: String {
        return self?.isEmpty ?? true ? "" : self!
    }
}
