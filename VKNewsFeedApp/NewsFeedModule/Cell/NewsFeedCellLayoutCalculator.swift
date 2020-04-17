//
//  NewsFeedCellLayoutCalculator.swift
//  VKNewsFeedApp
//
//  Created by Danya on 08.04.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import UIKit
import VKNetworkService

struct Sizes: NewsFeedCellSizes {
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

protocol NewsFeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: PhotoAttachment?, textIsFullSized: Bool) -> NewsFeedCellSizes
}

final class NewsFeedCellLayoutCalculator: NewsFeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }
   
    func sizes(postText: String?, photoAttachment: PhotoAttachment?, textIsFullSized: Bool) -> NewsFeedCellSizes {
    
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        
        // MARK: - postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left,
                                                    y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.getHeight(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitsLine
            
            if height > limitHeight && !textIsFullSized {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: - showMoreTextButton
        
        let moreTextButtonSize = showMoreTextButton ? Constants.moreTextButtonText.size(withAttributes: [.font: Constants.moreTextButtonFont]) : CGSize.zero
        
        let moreTextButtonFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left,
                                                         y: postLabelFrame.maxY),
                                         size: moreTextButtonSize)
        
        // MARK: - postAttachmentFrame
    
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                     size: CGSize.zero)
        
        if let attachment = photoAttachment {
            let photoHeight: Float = Float(attachment.postHeight)
            let photoWidth: Float = Float(attachment.postWidth)
            
            let ratio = CGFloat(photoHeight / photoWidth)
         
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        // MARK: - buttonViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                 size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        // MARK: - totalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
    
}
