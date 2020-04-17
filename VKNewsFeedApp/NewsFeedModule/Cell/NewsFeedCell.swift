//
//  NewsFeedCell.swift
//  VKNewsFeed
//
//  Created by Danya on 25.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import UIKit
import Kingfisher

//protocol FeedCellViewModel {
//    var iconUrlString: String { get }
//    var name: String { get }
//    var date: String { get }
//    var text: String? { get }
//    var likes: String? { get }
//    var comments: String? { get }
//    var shares: String? { get }
//    var views: String? { get }
//    
//    var photoUrlString: String? { get }
//    var width: Int { get }
//    var height: Int { get }
//    
//    var sizes: NewsFeedCellSizes { get }
//}

protocol NewsFeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
    var moreTextButtonFrame: CGRect { get } 
}

class NewsFeedCell: UITableViewCell {

    static let reuseId = "NewsFeedCell"
    
    @IBOutlet weak private var mainView: UIView!
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var postLabel: UILabel!
    @IBOutlet weak private var postImageView: UIImageView!
    @IBOutlet weak private var likesLabel: UILabel!
    @IBOutlet weak private var commentsLabel: UILabel!
    @IBOutlet weak private var sharesLabel: UILabel!
    @IBOutlet weak private var viewsLabel: UILabel!
    @IBOutlet weak private var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func set(post: PresentationPost) {
        let iconUrl = URL(string: post.iconUrlString)
        iconImageView.kf.setImage(with: iconUrl)
        
        if let imageURL = URL(string: post.photoAttachment?.postUrlString ?? "") {
            postImageView.kf.setImage(with: imageURL)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        
        nameLabel.text = post.name
        dateLabel.text = post.date
        postLabel.text = post.text
        likesLabel.text = post.likes
        commentsLabel.text = post.comments
        sharesLabel.text = post.shares
        viewsLabel.text = post.views

        postLabel.frame = post.sizes.postLabelFrame
        postImageView.frame = post.sizes.attachmentFrame
        bottomView.frame = post.sizes.bottomViewFrame
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
