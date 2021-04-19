//
//  ViewController.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 19/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchView: RoundedView!
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var controller: FeedDataSourceDelegateController?
    var request = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = FeedDataSourceDelegateController(view: self)
        feedTableView.delegate = controller
        feedTableView.dataSource = controller
        
        setupUI()
       getData(apiUrl: "")
        // Do any additional setup after loading the view.
    }
    func getData(apiUrl: String){
        var url = "https://newsapi.org/v2/top-headlines?country=ca&apiKey=aef42a10dc9d4ea0b9b8467ab623851a"
        if apiUrl != "" {
            url = apiUrl
        }
        self.request.getNews(url: url, completionHandler: {[weak self] news, error in
            self?.loadData(news: news)
        })
    }
    
    func loadData(news: [News]){
        controller?.news = news
        feedTableView.reloadData()
    }
    @IBAction func indexChanged(_ sender: Any) {
        switch  segmentedControl.selectedSegmentIndex {
        case 0:
            self.getData(apiUrl: "https://newsapi.org/v2/top-headlines?country=ca&apiKey=aef42a10dc9d4ea0b9b8467ab623851a")
        case 1:
            self.getData(apiUrl: "https://newsapi.org/v2/top-headlines?country=ca&category=health&apiKey=aef42a10dc9d4ea0b9b8467ab623851a")
        case 2:
            self.getData(apiUrl: "https://newsapi.org/v2/top-headlines?country=ca&category=technology&apiKey=aef42a10dc9d4ea0b9b8467ab623851a")
        default:
            break
        }
    }
    func setupUI(){
              segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
              
              segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
            //colors black: 1C1C1C, White: FFFFFF, gray: 504E54
        
              //topView.backgroundColor = UIColor(hexString: "FFFFFF")
              searchView.backgroundColor = UIColor(hexString: "FFFFFF")
              searchView.layer.borderWidth = 1
        
              searchView.layer.borderColor = UIColor(hexString: "1C1C1C").cgColor
               categoriesView.roundCorners(.allCorners, radius: 15)
              
              
           self.view.backgroundColor = UIColor(hexString: "1C1C1C")
              categoriesView.backgroundColor = UIColor(hexString: "504E54")
    }
}
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius) )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

