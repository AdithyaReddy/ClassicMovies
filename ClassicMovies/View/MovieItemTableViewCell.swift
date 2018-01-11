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
    
    static func createModel(imageUrl: String, title: String) {
        return MovieItemTableViewCellModel(imageUrl: imageUrl, title: imageUrl)
    }
    
}

class MovieItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backdropImageView: UIImageView?
    @IBOutlet weak var title: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MovieItemTableViewCell {
    func bindDataModel(model: MovieItemTableViewCellModel) {
        if let imageUrl = URL(string: imageUrl) {
            
        }
    }
}
