//
//  ViewControllerAssembly.swift
//  VKNewsFeed
//
//  Created by Danya on 19.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import Foundation
import VKAuthorizationService
import VKNetworkService

class StartPageViewControllerAssembly {
    private lazy var authServiceAssembly = VKAuthServiceAssembly()
    private lazy var routerAssembly = StartPageRouterAssembly()
    
    var startVC: UIViewController {
        let storyboard = UIStoryboard(name: "StartPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StartPageViewController") as! StartPageViewController
        vc.authService = authServiceAssembly.service(with: AuthServiceConfiguration(appId: "7388676", permissions: ["wall", "friends"]), controller: vc)
        vc.authService.output = vc
        vc.router = routerAssembly.router
        
        return vc
    }
}
