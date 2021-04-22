//
//  FeedTableViewCell.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 19/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: RoundedView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var saveView: RoundedView!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var favorites: Bool?
    
    var favoritesTap :  (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favoritesButton(_ sender: Any) {
        favoritesTap()
    }
    
    func setup(news: News){
        titleLabel.text = news.title
        
        contentView.backgroundColor = UIColor(hexString: "1C1C1C")
         saveView.backgroundColor = UIColor(hexString: "1C1C1C")
        cardView.backgroundColor = UIColor(hexString: "404040")
        
        if let newsUrl = news.urlToImage {
            let url = URL(string: newsUrl)
            newsImageView.kf.setImage(with: url)
        }else {
           
            let url = URL(string: "https://images.unsplash.com/photo-1529243856184-fd5465488984?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1369&q=80")
            newsImageView.kf.setImage(with: url)
        }
       
    }

}
