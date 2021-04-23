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
    @IBOutlet weak var spinner: Spinner!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    var controller: FeedDataSourceDelegateController?
    @IBOutlet weak var leftConstraints: NSLayoutConstraint!
    var request = APIManager()
    private var shouldCollapse = true
    
    var buttonSearch: Bool {
        return shouldCollapse ? true : false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchBar.isHidden = true
        controller = FeedDataSourceDelegateController(view: self)
        searchBar.delegate = controller
        feedTableView.delegate = controller
        feedTableView.dataSource = controller
        spinner.hidesWhenStopped = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        getData(apiUrl: "")
        segmentedControl.selectedSegmentIndex = 0
        getSavesNews()
    }
    func getSavesNews(){
        controller?.findItem(completionHandler: { success, _ in
            if success {
                self.feedTableView.reloadData()
            }
        })
    }
    func getData(apiUrl: String){
        var url = "https://newsapi.org/v2/top-headlines?country=ca&apiKey=aef42a10dc9d4ea0b9b8467ab623851a"
        if apiUrl != "" {
            url = apiUrl
        }
        spinner.isHidden = false
        spinner.startAnimating()
        self.request.getNews(url: url, completionHandler: {[weak self] news, error in
            self?.loadData(news: news)
        })
    }
    
    func loadData(news: [News]){
        controller?.news = news
        feedTableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
        
        
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
              searchView.backgroundColor = UIColor(hexString: "1C1C1C")
              searchView.layer.borderWidth = 1
        
              searchView.layer.borderColor = UIColor(hexString: "FFFFFF").cgColor
              categoriesView.roundCorners(.allCorners, radius: 10)
              
              searchBar.barTintColor = UIColor(hexString: "1C1C1C")
              self.view.backgroundColor = UIColor(hexString: "1C1C1C")
              categoriesView.backgroundColor = UIColor(hexString: "504E54")
    }
    
    @IBAction func filterButton(_ sender: Any) {
        if shouldCollapse {
            searchBar.isHidden = false
            searchButton.setImage(nil, for: .normal)
            animateView(isCollapse: false, widthConstraint: 20)
        }else{
            
            searchBar.isHidden = true
            controller?.resetTable()
            searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            animateView(isCollapse: true, widthConstraint: 208)
        }
    }
    
    private func animateView(isCollapse: Bool, widthConstraint: Double){
        shouldCollapse = isCollapse
        leftConstraints.constant = CGFloat(widthConstraint)
        UIView.animate(withDuration: 1){
            self.view.layoutIfNeeded()
        }
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

