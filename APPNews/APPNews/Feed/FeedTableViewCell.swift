//
//  FeedTableViewCell.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 19/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardView: RoundedView!
    @IBOutlet weak var cardBackground: RoundedView!
    @IBOutlet weak var cardDetail: RoundedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(news: News){
        titleLabel.text = news.title
        nameLabel.text = news.source?.name
        descriptionLabel.text = news.description
        contentView.backgroundColor = UIColor(hexString: "1C1C1C")
        cardView.backgroundColor = UIColor(hexString: "FFFFFF")
        cardBackground.backgroundColor = UIColor(patternImage: UIImage(named: "cardBack")!)
       
    }

}
