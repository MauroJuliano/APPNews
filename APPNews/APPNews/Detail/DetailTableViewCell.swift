//
//  DetailTableViewCell.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 20/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher
class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
      @IBOutlet weak var sourceLabel: UILabel!
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupUI(news: News){
        
        sourceLabel.text =  news.author
        authorLabel.text = news.source?.name
        titleLabel.text = news.title
        contentLabel.text = news.content
        if let image = news.urlToImage{
            let url = URL(string: image)
            newsImage.kf.setImage(with: url)
        }
        
    }

}
