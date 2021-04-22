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
    var savedNews = [Archive]()
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
           
            if cell.favoritesButton.image(for: .normal)?.pngData() == UIImage(systemName: "star")?.pngData() {
               self.archiveItens(news: self.news[indexPath.row])
                cell.favoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }else{
                cell.favoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
                self.deleteFavorite(title: self.news[indexPath.row].title ?? "")
            }
        }
        
        if savedNews.contains(where: {$0.title == news[indexPath.row].title}) {
            cell.favoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
             cell.favoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        return cell
    }

    func findItem( completionHandler: @escaping (_ result: Bool, _ error: Error? ) -> Void){
            savedNews.removeAll()
            let realmData = realm.objects(Archive.self)
            savedNews.append(contentsOf: realmData)
            completionHandler(true, nil)
        
    }
    
    func deleteFavorite(title: String){
        let predicate = NSPredicate(format: "title = %@", title)
        if let realmData = realm.objects(Archive.self).filter(predicate).first {
        try! self.realm.write {
            self.realm.delete(realmData)
        }
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
