//
//  ViewController.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 19/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var categoriesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.roundCorners(.allCorners, radius: 15)
        searchView.backgroundColor = UIColor(hexString: "1C1C1C")
        searchView.layer.borderWidth = 2
        searchView.layer.borderColor = UIColor.white.cgColor
         categoriesView.roundCorners(.allCorners, radius: 20)
        
        
        self.view.backgroundColor = UIColor(hexString: "1C1C1C")
        categoriesView.backgroundColor = UIColor(hexString: "504E54")
        // Do any additional setup after loading the view.
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

