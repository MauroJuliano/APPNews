//
//  DetailViewController.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 20/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    var news: News?
    @IBOutlet weak var detailTableView: UITableView!
    var newsArra = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "1C1C1C")
        newsArra.append(News(title: news?.title, description: news?.description, url: news?.url, publishedAt: news?.publishedAt, urlToImage: news?.urlToImage, source: news?.source, content: news?.content, author: news?.author))
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
}
extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArra.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        cell.setupUI(news: newsArra[indexPath.row])
        return cell
    }
    
    
}
