//
//  NewsFeedModel.swift
//  VKNewsFeed
//
//  Created by Danya on 20.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import Foundation
import VKNetworkService
import VKAuthorizationService

protocol NewsFeedModel {
    var output: NewsFeedModelOutput? { get set }
    
    var presentationPosts: [PresentationPost] { get set }
    func load()
}

protocol NewsFeedModelOutput {
    func updateViewFromModel()
}

class NewsFeedModelImpl: NewsFeedModel {
    var storage: Storage!
    var networkService: NetworkService! // injected
    var authService: AuthService! // injected
    
    var output: NewsFeedModelOutput?
    var presentationPosts: [PresentationPost] = []
    
    let dateFormatter: DateFormatter = {
        let date = DateFormatter()
        date.locale = Locale(identifier: "ru_RU")
        date.dateFormat = "d MMM 'в' HH:mm"
        return date
    }()
    
    func load() {
        guard let token = authService.token else { return } 
        networkService.getData(token: token, method: API.newsFeed, params: ["filters" : "post, photo"]) { (feedResponse) in
            
            self.storage.setStoragePosts(storagePosts: feedResponse.items.map{ (item) -> StoragePost in
                let source = self.identifyNewsSource(sourceId: item.sourceId!,
                                                     profiles: feedResponse.profiles,
                                                     groups: feedResponse.groups)
                let date = Date(timeIntervalSince1970: item.date!)
                let dateTitle = self.dateFormatter.string(from: date)
                
                return StoragePost(name: source.name,
                                   iconUrlString: source.photo,
                                   date: dateTitle,
                                   text: item.text ?? "",
                                   likes: String(item.likes?.count ?? 0),
                                   comments: String(item.comments?.count ?? 0),
                                   shares: String(item.reposts?.count ?? 0),
                                   views: String(item.views?.count ?? 0),
                                   postUrlString: item.attachments?.first?.photo?.url ?? "",
                                   postHeight: item.attachments?.first?.photo?.height ?? 0,
                                   postWidth: item.attachments?.first?.photo?.width ?? 0)
            })
        }
    }
    
    private func identifyNewsSource(sourceId: Int,
                                    profiles: [Profile],
                                    groups: [Group]) -> SourceRepresentable {
        
        let sources: [SourceRepresentable] = sourceId > 0 ? profiles : groups
        let normalSourceId = sourceId > 0 ? sourceId : -sourceId
        let source = sources.first { (source) -> Bool in
            source.id == normalSourceId
        }
        
        return source! 
    }
    
//    private func getPropperPhoto(attachments: [Attachment]) -> PhotoSize {
//        
//        
//        
//    }
    
    
    
}

extension NewsFeedModelImpl: StorageOutput {
    func collectionChanged(newValue: [StoragePost]) {
        presentationPosts = newValue.map{ (storagePost) -> PresentationPost in
            return PresentationPost(name: storagePost.name,
                                    iconUrlString: storagePost.iconUrlString,
                                    date: storagePost.date,
                                    text:  storagePost.text,
                                    likes: storagePost.likes,
                                    comments: storagePost.comments,
                                    shares: storagePost.shares,
                                    views: storagePost.views,
                                    postUrlString: storagePost.postUrlString,
                                    postHeight: storagePost.postHeight,
                                    postWidth: storagePost.postWidth)
        }
        output?.updateViewFromModel()
    }
    
    
}
