//
//  Archive.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 20/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//
import UIKit
import Foundation
import RealmSwift

class Archive: Object {
      @objc dynamic var title = ""
       @objc dynamic var resume = ""
       @objc dynamic var url = ""
       @objc dynamic var publishedAt = ""
       @objc dynamic var urlToImage = ""
       @objc dynamic var source = ""
       @objc dynamic var content = ""
       @objc dynamic var author = ""
       
}
