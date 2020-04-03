//
//  ViewController.swift
//  VKNewsFeed
//
//  Created by Danya on 19.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import UIKit
import VKAuthorizationService
import VKNetworkService

class StartPageViewController: UIViewController {
    var authService: AuthService! // injected
    
    var router: StartPageRouter! // Router
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButtonPressed(_ sender: UIButton) {
        authService.start()

    }
    
}


extension StartPageViewController: AuthServiceOutput {
    func goBackToVC() {
        
        
        router.showFeedVC(in: self)
    }

    
    
}
