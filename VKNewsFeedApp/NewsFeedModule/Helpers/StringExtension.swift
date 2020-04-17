//
//  StringExtension.swift
//  VKNewsFeedApp
//
//  Created by Danya on 14.04.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import UIKit

extension String {
    func getHeight(width: CGFloat, font: UIFont) -> CGFloat {
        
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
}
