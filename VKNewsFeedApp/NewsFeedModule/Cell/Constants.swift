//
//  Constants.swift
//  VKNewsFeedApp
//
//  Created by Danya on 14.04.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 45
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8,
                                              left: 8,
                                              bottom: 8,
                                              right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 17)
    static let bottomViewHeight: CGFloat = 44
    
    static let bottomViewViewWidth: CGFloat = 80
    
    static let bottomViewViewsIconSize: CGFloat = 24
    
    static let minifiedPostLimitsLine: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    
    static let moreTextButtonFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    static let moreTextButtonText = "Show full text..." 
}
