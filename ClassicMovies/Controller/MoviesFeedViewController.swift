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
    fileprivate lazy var dataSource: [CMMovie]? = {
        let movies = CMMovie.mr_findAll()
        return movies as? [CMMovie]
    }()
    fileprivate var currentPageNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Classic Movies"
        registerXIBs()
        fetchFeed()
    }
    
    func fetchFeed() {
        movieFeedOperation?.getMovieFeed(page: currentPageNumber, onSuccess: { [weak self] (feed) in
            self?.currentPageNumber += 1
            self?.feed = feed
            if let moreMovies = feed.results?.allObjects as? [CMMovie] {
                
               
                var indexPaths: [IndexPath] = []
                if var count = self?.dataSource?.count {
                    moreMovies.forEach({ (_) in
                        let indexPath = IndexPath(row: count, section: 0)
                        indexPaths.append(indexPath)
                        count += 1
                    })
                }
                
                self?.dataSource?.append(contentsOf: moreMovies)
                self?.moviesListTableView.reloadData()
            }
        
            //self?.moviesListTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let dataSource = self.dataSource, indexPath.row == dataSource.count - 2 {
            fetchFeed()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemTableViewCell") as? MovieItemTableViewCell {
            if let dataSource = dataSource, dataSource.count > indexPath.row {
                
                let movie = dataSource[indexPath.row]
                let imagePath =  movie.backdropPath ?? ""
                let title = movie.originalTitle ?? ""
                if let movieModel = MovieItemTableViewCellModel.createModel(imageUrl: imagePath, title: title, voteAvg: movie.voteAverage ?? 0, voteCount: movie.voteCount ?? 0) {
                    cell.bindDataModel(model: movieModel)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
