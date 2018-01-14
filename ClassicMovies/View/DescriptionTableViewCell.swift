//
//  DescriptionTableViewCell.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 14/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    static let cellIdentifier: String = "DescriptionTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 30
    }
    
    override var intrinsicContentSize : CGSize {
        var intrinsicSize = super.intrinsicContentSize
        let constraintsSum: CGFloat = 35
        intrinsicSize.height = titleLabel.intrinsicContentSize.height + constraintsSum
        return intrinsicSize
    }
}

extension DescriptionTableViewCell {
    func bindDataModel(model: AnyObject) {
        if let model = model as? String {
            titleLabel.text = "'\(model)'"
        }
    }
}
