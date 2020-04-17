//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Danya on 19.03.2020.
//  Copyright © 2020 Daniil Girskiy. All rights reserved.
//

import UIKit


class NewsFeedViewController: UIViewController {
    
    // MARK: - Properties
    
    var model: NewsFeedModel! // injected
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        model.load()
        
        configureUI()
    }
    
    // MARK: - Handlers
    
    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseId)
        tableView.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.presentationPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as! NewsFeedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell
        let post = model.presentationPosts[indexPath.row]
        
        cell.moreTextButtonPressedClosure = {
            self.model.revealFullText(at: indexPath.row)
        }
    
        cell.set(post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = model.presentationPosts[indexPath.row]
        return post.sizes.totalHeight
//        return 212
    }
}

extension NewsFeedViewController: NewsFeedModelOutput {
    func updateViewFromModel() {
        tableView.reloadData()
        print("NewsFeedView updated from model")
    }
}
