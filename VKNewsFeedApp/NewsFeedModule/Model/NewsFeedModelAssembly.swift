//
//  NewsFeedModelAssembly.swift
//  VKNewsFeed
//
//  Created by Danya on 20.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import Foundation
import VKNetworkService
import VKAuthorizationService

class NewsFeedModelAssembly {
    private lazy var networkServiceAssembly = VKNetworkServiceAssembly()
    private lazy var authServiceAssembly = VKAuthServiceAssembly()
    private lazy var storageAssembly = StorageAssembly()
    
    var model: NewsFeedModel {
        let model = NewsFeedModelImpl()
        model.networkService = networkServiceAssembly.network
        model.authService = authServiceAssembly.service()
        model.storage = storageAssembly.storage
        model.storage.output = model
        
        return model
    }
}
