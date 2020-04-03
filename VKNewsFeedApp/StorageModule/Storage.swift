//
//  Storage.swift
//  VKNewsFeed
//
//  Created by Danya on 25.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import Foundation

protocol Storage {
    var output: StorageOutput? { get set }
    
    func setStoragePosts(storagePosts: [StoragePost])
}

protocol StorageOutput {
    func collectionChanged(newValue: [StoragePost])
}

class StorageImpl: Storage {
    var output: StorageOutput?
    
    var storagePosts: [StoragePost] = []
    
    func setStoragePosts(storagePosts: [StoragePost]) {
        self.storagePosts = storagePosts
        output?.collectionChanged(newValue: storagePosts)
    }
    
}
