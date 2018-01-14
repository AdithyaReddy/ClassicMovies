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
    fileprivate var expandedMovies: [CMMovie] = []
    var descriptionTableViewCell: DescriptionTableViewCell!
    
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
            }, onError: { (error, statusCode) in
                print(error)
        })
    }
    
    func registerXIBs() {
        descriptionTableViewCell = Bundle.main.loadNibNamed(DescriptionTableViewCell.cellIdentifier, owner: self, options: nil)![0] as? DescriptionTableViewCell
        moviesListTableView.register(UINib(nibName: TitleDescTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: TitleDescTableViewCell.cellIdentifier)
        moviesListTableView.register(UINib(nibName: DescriptionTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: DescriptionTableViewCell.cellIdentifier)
        moviesListTableView.register(UINib(nibName: MovieThumbnailHeaderView.cellIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: MovieThumbnailHeaderView.cellIdentifier)
        
    }

}

extension MoviesFeedViewController: UITableViewDelegate {
    
}

extension MoviesFeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movie = checkIfMovieIsExpanded(in: section) {
            return movie.itemsAvailable.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let dataSource = self.dataSource, indexPath.section == dataSource.count - 2 {
            fetchFeed()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let movie = checkIfMovieIsExpanded(in: indexPath.section) {
            
            switch movie.itemsAvailable[indexPath.row] {
                case .Overview:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.cellIdentifier) as? DescriptionTableViewCell {
                        cell.bindDataModel(model: movie.overview as AnyObject)
                        return cell
                    }
                case .OriginalLang:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: TitleDescTableViewCell.cellIdentifier) as? TitleDescTableViewCell {
                        if let model = TitleDescTableViewCellModel.createModel(title: "Original Language", desc: movie.originalLang) {
                            cell.bindDataModel(model: model as AnyObject)
                        }
                        return cell
                    }
                case .Popularity:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: TitleDescTableViewCell.cellIdentifier) as? TitleDescTableViewCell {
                        if let model = TitleDescTableViewCellModel.createModel(title: "Popularity", desc: "\(movie.popularity ?? 0)") {
                            cell.bindDataModel(model: model as AnyObject)
                        }
                        return cell
                    }
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieThumbnailHeaderView.cellIdentifier) as? MovieThumbnailHeaderView {
            if let dataSource = dataSource, dataSource.count > section {
                let movie = dataSource[section]
                let imagePath =  movie.backdropPath ?? ""
                let title = movie.originalTitle ?? ""
                if let movieModel = MovieThumbnailHeaderViewModel.createModel(imageUrl: imagePath, title: title, voteAvg: movie.voteAverage ?? 0, voteCount: movie.voteCount ?? 0, cellSection: section) {
                    header.delegate = self
                    header.bindDataModel(model: movieModel)
                }
            }
            return header
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let movie = checkIfMovieIsExpanded(in: indexPath.section) {
            switch movie.itemsAvailable[indexPath.row] {
                case .Overview:
                    descriptionTableViewCell.frame.size.width = UIScreen.main.bounds.width
                    descriptionTableViewCell.bindDataModel(model: movie.overview as AnyObject)
                    descriptionTableViewCell.setNeedsLayout()
                    descriptionTableViewCell.layoutIfNeeded()
                    return descriptionTableViewCell.intrinsicContentSize.height
                case .OriginalLang:
                    return 50
                case .Popularity:
                    return 50
            }
        }
        return 0
    }
}

/* View controller helper functions */
extension MoviesFeedViewController {
    func checkIfMovieIsExpanded(in section: Int) -> CMMovie? {
        let movies = expandedMovies.filter { (movie) -> Bool in
            if dataSource![section].id == movie.id {
                return true
            }
            return false
        }
        if movies.count > 0 {
            return movies.first
        }
        return nil
    }
}

extension MoviesFeedViewController: MovieThumbnailHeaderViewDelegate {
    func clickedOnHeader(headerView: MovieThumbnailHeaderView) {
        if let tappedSection = headerView.cellSection {
            let movie: CMMovie = dataSource![tappedSection]
            if !expandedMovies.contains(movie) {
                expandedMovies.append(movie)
                var i = 0
                var indexPaths: [IndexPath] = []
                movie.itemsAvailable.forEach({ (_) in
                    let ip = IndexPath(row: i, section: tappedSection)
                    indexPaths.append(ip)
                    i += 1
                })
                if indexPaths.count > 0 {
                    self.moviesListTableView.beginUpdates()
                    self.moviesListTableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.none)
                    self.moviesListTableView.endUpdates()
                }
            } else {
                let _ = expandedMovies.index(of: movie).map { expandedMovies.remove(at: $0) }
                var i = 0
                var indexPaths: [IndexPath] = []
                movie.itemsAvailable.forEach({ (_) in
                    let ip = IndexPath(row: i, section: tappedSection)
                    indexPaths.append(ip)
                    i += 1
                })
                if indexPaths.count > 0 {
                    self.moviesListTableView.beginUpdates()
                    self.moviesListTableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.none)
                    self.moviesListTableView.endUpdates()
                }
            }
        }
    }
}
