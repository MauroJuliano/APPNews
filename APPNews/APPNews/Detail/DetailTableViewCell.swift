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
    @IBOutlet weak var sourceButton: UIButton!
  
    var sourceTap :  (() -> ()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func sourceButton(_ sender: Any) {
        sourceTap()
    }
    
    func setupUI(news: News){
         contentView.backgroundColor =  UIColor(hexString: "1C1C1C")
        sourceLabel.text =  news.author
        //authorLabel.text = news.source?.name
        titleLabel.text = news.title
        contentLabel.text = news.content
        
        if let sourceName = news.source?.name {
            sourceButton.setTitle(sourceName, for: .normal)
        }else {
            sourceButton.setTitle("Click here", for: .normal)
        }
        
        if let image = news.urlToImage{
            let url = URL(string: image)
            newsImage.kf.setImage(with: url)
        }
        else {
            let url = URL(string: "https://images.unsplash.com/photo-1529243856184-fd5465488984?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1369&q=80")
            newsImage.kf.setImage(with: url)
        }
        
    }

}
