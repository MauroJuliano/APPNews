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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardView: RoundedView!
    @IBOutlet weak var cardBackground: RoundedView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var cardDetail: RoundedView!
    
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
        // nameLabel.text = news.source?.name
       // descriptionLabel.text = news.description
        contentView.backgroundColor = UIColor(hexString: "1C1C1C")
        cardView.backgroundColor = UIColor(hexString: "404040")
        //cardBackground.backgroundColor = UIColor(patternImage: UIImage(named: "cardBack")!)
        
        if let newsUrl = news.urlToImage {
            let url = URL(string: newsUrl)
            newsImageView.kf.setImage(with: url)
        }
        
       
    }

}
