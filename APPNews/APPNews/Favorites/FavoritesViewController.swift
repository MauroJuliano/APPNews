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
        
        let realmData = realm.objects(Archive.self)
        newsArchive.append(contentsOf: realmData)
        
        archiveTableView.delegate = self
        archiveTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArchive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "archiveCell", for: indexPath) as! NewsArchiveTableViewCell
        cell.setup(news: newsArchive[indexPath.row])
        return cell
    }
    
    
}
