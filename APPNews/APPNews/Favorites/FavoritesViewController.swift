//
//  FavoritesViewController.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 19/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import RealmSwift
class FavoritesViewController: UIViewController {

    @IBOutlet weak var archiveTableView: UITableView!
    var newsArchive = [Archive]()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "1C1C1C")
        
        
        archiveTableView.delegate = self
        archiveTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        newsArchive.removeAll()
        
        let realmData = realm.objects(Archive.self)
        newsArchive.append(contentsOf: realmData)
        
        archiveTableView.reloadData()
    }
    
    func deleteFavorite(title: String){
        let predicate = NSPredicate(format: "title = %@", title)
        if let realmData = realm.objects(Archive.self).filter(predicate).first {
        try! self.realm.write {
            self.realm.delete(realmData)
        }
        }
    }
    
}
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController {
            vc.archive = newsArchive[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArchive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "archiveCell", for: indexPath) as! NewsArchiveTableViewCell
        cell.setup(news: newsArchive[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = UIContextualAction.init(style: .normal
        , title: "Unarchive") { (action, view, completion) in
      
            self.newsArchive.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.deleteFavorite(title: self.newsArchive[indexPath.row].title)
            completion(true)
        }
        
        complete.image = UIImage(systemName: "archivebox.fill")
        complete.backgroundColor = UIColor(hexString: "bb9ffc")
        let action = UISwipeActionsConfiguration.init(actions: [complete])
        action.performsFirstActionWithFullSwipe = true
        
        return action
    }
    
    
}
