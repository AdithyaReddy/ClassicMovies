//
//  TitleDescTableViewCell.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 14/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

struct TitleDescTableViewCellModel {
    var title: String
    var desc: String
    
    static func createModel(title: String?, desc: String?) -> TitleDescTableViewCellModel? {
        let titleStr = title ?? ""
        let descStr = desc ?? ""
        return TitleDescTableViewCellModel(title: titleStr, desc: descStr)
    }
}

class TitleDescTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    static let cellIdentifier: String = "TitleDescTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension TitleDescTableViewCell {
    func bindDataModel(model: AnyObject) {
        if let model = model as? TitleDescTableViewCellModel {
            titleLabel.text = model.title
            descLabel.text = model.desc
        }
    }
}
