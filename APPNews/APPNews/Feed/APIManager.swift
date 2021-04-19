//
//  APIManager.swift
//  APPNews
//
//  Created by Mauro Figueiredo on 19/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import Alamofire

struct News: Decodable {
    let title: String?
    let description: String?
    let url: String?
    let publishedAt: String?
    
    let source: source?
}
struct NewsList: Decodable{
    let articles: [News]
}

struct source: Decodable {
    let name: String?
    
}

class APIManager {
    func getNews(url: String, completionHandler: @escaping (_ result: [News], _ error: Error?) -> Void){
        AF.request(url).responseDecodable { (response: DataResponse<NewsList, AFError>) in
           // debugPrint(try? response.result.get())
            do {
                let result = try response.result.get()
                completionHandler(result.articles, nil)
            }catch {
                completionHandler([], error)
            }
        }
    }
}
