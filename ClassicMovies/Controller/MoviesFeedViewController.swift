//
//  MoviesFeedViewController.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 07/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

class MoviesFeedViewController: UIViewController {

    fileprivate lazy var moviesListTableView: UITableView = {
       let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        return tableView
    }()
    
    fileprivate lazy var movieFeedOperation: MovieFeedOperationProtocol? = {
       let movieFeedOperation = MovieFeedOperation()
        return movieFeedOperation
    }()
    
    fileprivate var feed: CMFeed?
    fileprivate var dataSource: [CMMovie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXIBs()
        fetchFeed()
    }
    
    func fetchFeed() {
        movieFeedOperation?.getMovieFeed(onSuccess: { [weak self] (feed) in
            self?.feed = feed
            self?.dataSource = feed.results?.allObjects
            self?.moviesListTableView.reloadData()
            }, onError: { (error, statusCode) in
                print(error)
        })
    }
    
    func registerXIBs() {
        moviesListTableView.register(UINib(nibName: "MovieItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieItemTableViewCell")
    }

}

extension MoviesFeedViewController: UITableViewDelegate {
    
}

extension MoviesFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemTableViewCell") as? MovieItemTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
