//
//  NewsArchiveTableViewCell.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 20/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher

class NewsArchiveTableViewCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(news: Archive){
        titleLabel.text = news.title
        contentView.backgroundColor = UIColor(hexString: "1C1C1C")
       // sourceLabel.text = news.source
        
        if news.urlToImage != "" {
            let url = URL(string: news.urlToImage)
                   newsImage.kf.setImage(with: url!)
                   print(url!)
        }
       
            
        
    }

}
