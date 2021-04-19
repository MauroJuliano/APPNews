//
//  FeedDataSourceDelegateController.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 19/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit

class FeedDataSourceDelegateController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var view: ViewController?
    var news = [News]()
    init(view: ViewController){
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        cell.setup(news: news[indexPath.row])
        return cell
    }
    
    
}
