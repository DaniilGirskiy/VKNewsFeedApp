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
    
    func revealFullText(index: Int) // по айдишнику или по индексу?
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
    
    func revealFullText(index: Int) {
        storagePosts[index] = StoragePost(name: storagePosts[index].name,
                                          iconUrlString: storagePosts[index].iconUrlString,
                                          date: storagePosts[index].date,
                                          text: storagePosts[index].text,
                                          likes: storagePosts[index].likes,
                                          comments: storagePosts[index].comments,
                                          shares: storagePosts[index].shares,
                                          views: storagePosts[index].views,
                                          photoAttachment: storagePosts[index].photoAttachment,
                                          fullPostTextIsRevealed: true,
                                          sizes: storagePosts[index].sizes)
        
        output?.collectionChanged(newValue: storagePosts)
    }
    
}
