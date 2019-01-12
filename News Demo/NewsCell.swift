//
//  NewsCell.swift
//  News Demo
//
//  Created by Evolusolve on 12/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var news: News? {
        didSet {
            if let news = news {
                titleLabel.text = news.title
                descriptionLabel.text = news.description
                dateLabel.text = news.date
                
                if let urlString = news.imageUrl, let url = URL(string: urlString) {
                    thumbnailImageView.af_setImage(withURL: url, placeholderImage: UIImage(named: "Placeholder"))
                } else {
                    thumbnailImageView.image = UIImage(named: "Placeholder")
                }
            } else {
                titleLabel.text = nil
                descriptionLabel.text = nil
                dateLabel.text = nil
                thumbnailImageView.image = nil
            }
        }
    }
    
    override func prepareForReuse() {
        news = nil
    }
}
