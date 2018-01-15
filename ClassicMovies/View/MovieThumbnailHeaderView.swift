//
//  MovieThumbnailHeaderView.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 14/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

struct MovieThumbnailHeaderViewModel {
    var imageUrl: String
    var title: String
    var voteAvg: String
    var voteCount: String
    var cellSection: Int
    
    static func createModel(imageUrl: String, title: String, voteAvg: NSDecimalNumber, voteCount: NSNumber, cellSection: Int) -> MovieThumbnailHeaderViewModel? {
        let fullImageUrl = getFullImagePath(id: imageUrl)
        let voteAverage = "\(voteAvg)/10"
        let voteCountStr = "\(voteCount)"
        return MovieThumbnailHeaderViewModel(imageUrl: fullImageUrl, title: title, voteAvg: voteAverage, voteCount: voteCountStr, cellSection: cellSection)
    }
}

protocol MovieThumbnailHeaderViewDelegate: class {
    func clickedOnHeader(headerView: MovieThumbnailHeaderView)
}

class MovieThumbnailHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAvgLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var voteView: UIView!
    static let cellIdentifier: String = "MovieThumbnailHeaderView"
    weak var delegate: MovieThumbnailHeaderViewDelegate?
    var cellSection: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        voteView.clipsToBounds = true
        voteView.layer.cornerRadius = 8
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MovieThumbnailHeaderView.tapGestureAction))
        tapGesture.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
        //dropdownImageView.transform = .identity
    }
    
    func tapGestureAction() {
        delegate?.clickedOnHeader(headerView: self)
        //rotateImage(duration: 0.25)
    }
}

extension MovieThumbnailHeaderView {
    func bindDataModel(model: MovieThumbnailHeaderViewModel) {
        if let imageUrl = URL(string: model.imageUrl) {
            backdropImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "movie"), options: SDWebImageOptions.progressiveDownload, progress: nil, completed: nil)
        }
        titleLabel.text = model.title
        voteAvgLabel.text = model.voteAvg
        votesCountLabel.text = model.voteCount
        cellSection = model.cellSection
    }
}
