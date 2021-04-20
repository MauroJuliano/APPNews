//
//  FeedDataSourceDelegateController.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 19/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class FeedDataSourceDelegateController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var view: ViewController?
    var news = [News]()
    
    let newsToArchive = Archive()
    let realm = try! Realm()
    
    init(view: ViewController){
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController {
            vc.news = news[indexPath.row]
            view?.present(vc, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        cell.setup(news: news[indexPath.row])
        cell.favoritesTap = {
            self.archiveItens(news: self.news[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = UIContextualAction.init(style: .normal
        , title: "Archive") { (action, view, completion) in
            self.findItem()
            completion(true)
            
        }
        let action = UISwipeActionsConfiguration.init(actions: [complete])
        action.performsFirstActionWithFullSwipe = true
        return action
    }
    
    func findItem(){
        if (realm != nil){
                
                  let realmData = realm.objects(Archive.self)
                  print(realmData)
                
                
              }
    }
    func archiveItens(news: News?){
        if let saveNews = news {
            
            newsToArchive.author = saveNews.author ?? ""
            newsToArchive.title = saveNews.title ?? ""
            newsToArchive.resume = saveNews.description ?? ""
            newsToArchive.url = saveNews.url ?? ""
            newsToArchive.publishedAt = saveNews.publishedAt ?? ""
            newsToArchive.urlToImage = saveNews.urlToImage ?? ""
            newsToArchive.source = saveNews.source?.name ?? ""
            newsToArchive.content = saveNews.content ?? ""
          
            
            
            try! realm.write {
                  realm.add(newsToArchive)
            }
          
        }
        
    }
    
    
}
