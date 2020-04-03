//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Danya on 19.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import UIKit
import Kingfisher

class NewsFeedViewController: UIViewController {
    
    // MARK: - Properties
    
    var model: NewsFeedModel! // injected
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        
        model.load()
        
        configureUI()
    }
    
    // MARK: - Handlers
    
    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseId)
    }

}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.presentationPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as! NewsFeedCell
        let post = model.presentationPosts[indexPath.row]
            
        let iconURL = URL(string: post.iconUrlString)
        if let imageURL = URL(string: post.postUrlString) {
            cell.postImageView.kf.setImage(with: imageURL)
            cell.postImageView.isHidden = false
        } else {
            cell.postImageView.isHidden = true
        }
        
        cell.iconImageView.kf.setImage(with: iconURL)
        
        cell.nameLabel.text = post.name
        cell.dateLabel.text = post.date
        cell.postLabel.text = post.text
        cell.likesLabel.text = post.likes
        cell.commentsLabel.text = post.comments
        cell.sharesLabel.text = post.shares
        cell.viewsLabel.text = post.views
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

}


extension NewsFeedViewController: NewsFeedModelOutput {
    func updateViewFromModel() {
        tableView.reloadData()
        print("NewsFeedView updated from model")
    }
}
