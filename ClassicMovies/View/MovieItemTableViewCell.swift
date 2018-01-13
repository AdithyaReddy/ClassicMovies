//
//  MovieItemTableViewCell.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 07/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

struct MovieItemTableViewCellModel {
    var imageUrl: String
    var title: String
    var voteAvg: String
    var voteCount: String
    
    static func createModel(imageUrl: String, title: String, voteAvg: NSDecimalNumber, voteCount: NSNumber) -> MovieItemTableViewCellModel? {
        let fullImageUrl = getFullImagePath(id: imageUrl)
        let voteAverage = "\(voteAvg)/10"
        let voteCountStr = "\(voteCount)"
        return MovieItemTableViewCellModel(imageUrl: fullImageUrl, title: title, voteAvg: voteAverage, voteCount: voteCountStr)
    }
    
}

class MovieItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAvgLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var voteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        voteView.clipsToBounds = true
        voteView.layer.cornerRadius = 8
    }
}

extension MovieItemTableViewCell {
    func bindDataModel(model: MovieItemTableViewCellModel) {
        if let imageUrl = URL(string: model.imageUrl) {
            backdropImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "movie"), options: SDWebImageOptions.progressiveDownload, progress: nil, completed: nil)
        }
        titleLabel.text = model.title
        voteAvgLabel.text = model.voteAvg
        votesCountLabel.text = model.voteCount
    }
}



















