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
    var filtered = [News]()
    
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
        if filtered.count > 0 {
            return filtered.count
        }
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        
        if filtered.count > 0 {
            let filteredPath = filtered[indexPath.row]
            cell.setup(news: filteredPath)
        }else{
             cell.setup(news: news[indexPath.row])
        }
       
        
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
    func filterArray(searchIn: String){
        let options: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
        let searchText = searchIn.folding(options: options, locale: nil)
        
        filtered = news.filter({ (newsToFilter) -> Bool in
            guard !searchText.isEmpty else { return true}
            let newsToCompare = newsToFilter.title!.folding(options: options, locale: nil)
            return newsToCompare.contains(searchText)
        })
        view?.feedTableView.reloadData()
    }
    
    func archiveItens(news: News?){
        if let saveNews = news {
            
            newsToArchive.author = saveNews.author ?? ""
            newsToArchive.title = saveNews.title ?? ""
            newsToArchive.resume = saveNews.description ?? ""
            newsToArchive.url = saveNews.url ?? ""
            newsToArchive.publishedAt = saveNews.publishedAt ?? ""
            newsToArchive.urlToImage = saveNews.urlToImage ?? "https://images.unsplash.com/photo-1529243856184-fd5465488984?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1369&q=80"
            newsToArchive.source = saveNews.source?.name ?? ""
            newsToArchive.content = saveNews.content ?? ""
          

            try! realm.write {
                  realm.add(newsToArchive)
            }
          
        }
        
    }
}
extension FeedDataSourceDelegateController: UISearchBarDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 2 {
            filterArray(searchIn: searchText)
        }
        
    }
    func resetTable(){
        self.filtered.removeAll()
        view?.feedTableView.reloadData()
    }
}
