//
//  StorageAssembly.swift
//  VKNewsFeed
//
//  Created by Danya on 25.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import Foundation

class StorageAssembly {
    private static let storage = StorageImpl()
    
    var storage: Storage {
        return StorageAssembly.storage
    }
    
}
