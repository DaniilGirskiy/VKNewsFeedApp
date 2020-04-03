//
//  StartPageRouter.swift
//  VKNewsFeed
//
//  Created by Danya on 19.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import UIKit

class StartPageRouterAssembly {
    var router: StartPageRouter {
        let router = StartPageRouterImpl()
        return router
    }
}


protocol StartPageRouter {
    func showFeedVC(in vc: UIViewController)
}

class StartPageRouterImpl: StartPageRouter {
    var feedViewControllerAssembly = NewsFeedViewControllerAssembly()
    
    
    func showFeedVC(in vc: UIViewController) {
        vc.present(feedViewControllerAssembly.feedVC(), animated: true, completion: nil)
    }
    
}
