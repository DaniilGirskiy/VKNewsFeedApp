//
//  PresentationPost.swift
//  VKNewsFeed
//
//  Created by Danya on 25.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import Foundation

struct PresentationPost {
    let name: String
    let iconUrlString: String
    let date: String
    let text: String?
    let likes: String
    let comments: String
    let shares: String
    let views: String
    let photoAttachment: PhotoAttachment?
    let fullPostTextIsRevealed: Bool
    let sizes: NewsFeedCellSizes
}

struct PhotoAttachment {
    let postUrlString: String
    let postHeight: Int
    let postWidth: Int
}
