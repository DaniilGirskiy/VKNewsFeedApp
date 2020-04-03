//
//  FeedViewControllerAssembly.swift
//  VKNewsFeed
//
//  Created by Danya on 19.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import UIKit

class NewsFeedViewControllerAssembly {
    private lazy var newsFeedModelAssembly = NewsFeedModelAssembly()
    
    func feedVC() -> UIViewController {
        let feedVC = UIStoryboard(name: "NewsFeed", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! NewsFeedViewController
        feedVC.model = newsFeedModelAssembly.model
        feedVC.model.output = feedVC
        
        let navVC = UINavigationController(rootViewController: feedVC)
        navVC.modalPresentationStyle = .fullScreen
        return navVC
    }
    
}
