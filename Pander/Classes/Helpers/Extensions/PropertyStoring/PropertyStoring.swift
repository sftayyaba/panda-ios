//
//  PropertyStoring.swift
//  JobsNow
//
//  Created by Onebyte on 10/25/17.
//  Copyright © 2017 iDevz. All rights reserved.
//

import Foundation

protocol PropertyStoring {
    
    associatedtype T
    
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: T) -> T
}

extension PropertyStoring {
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: T) -> T {
        guard let value = objc_getAssociatedObject(self, key) as? T else {
            return defaultValue
        }
        return value
    }
}
