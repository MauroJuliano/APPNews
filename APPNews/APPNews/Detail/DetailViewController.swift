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
    var archive: Archive?
    @IBOutlet weak var detailTableView: UITableView!
    var newsArray = [News]()
    var sourceType: source?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "1C1C1C")
        
        if let savedNews = archive {
            newsArray.append(News(title: savedNews.title, description: savedNews.resume
                , url: savedNews.url, publishedAt: savedNews.publishedAt, urlToImage: savedNews.urlToImage, source: nil, content: savedNews.content, author: savedNews.author))
            print(savedNews.title)
        }
        
        newsArray.append(News(title: news?.title, description: news?.description, url: news?.url, publishedAt: news?.publishedAt, urlToImage: news?.urlToImage, source: news?.source, content: news?.content, author: news?.author))
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
}
extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        cell.setupUI(news: newsArray[indexPath.row])
        return cell
    }
    
    
}
