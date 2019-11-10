//
//  NewsProvider.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/9/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit
import Alamofire

class NewsProvider {
    
    private static let APIKey = "bbb787eb9b004bb7befee8e74bc9d005"
    
    class func fetchHeadlines(completion: @escaping ([News]?) -> Void, withCancel cancel: ((Error) -> ())?) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines") else {
            completion(nil)
            return
        }
        
        let parameters = ["country": "us",
                          "apiKey": APIKey]
        
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    if let err = response.result.error {
                        print("Error while fetching remote headlines: \(String(describing:response.result.error))")
                        cancel?(err)
                    }
                    return
                }
                
                guard let value = response.result.value as? [String: Any],
                    let articlesData = value["articles"] as? [[String: Any]] else {
                        print("Malformed data received from fetchHeadlines service")
                        completion(nil)
                        return
                }
                
                let newsList = articlesData.compactMap { newsDict in return News(jsonData: newsDict) }
                completion(newsList)
        }
    }
    
    class func fetchNews(keyword: String, completion: @escaping ([News]?) -> Void, withCancel cancel: ((Error) -> ())?) {
        guard let url = URL(string: "https://newsapi.org/v2/everything") else {
            completion(nil)
            return
        }
        
        let parameters = ["q": keyword,
                          "apiKey": APIKey]
        
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    if let err = response.result.error {
                        print("Error while fetching remote headlines: \(String(describing:response.result.error))")
                        cancel?(err)
                    }
                    return
                }
                
                guard let value = response.result.value as? [String: Any],
                    let articlesData = value["articles"] as? [[String: Any]] else {
                        print("Malformed data received from fetchHeadlines service")
                        completion(nil)
                        return
                }
                
                let newsList = articlesData.compactMap { newsDict in return News(jsonData: newsDict) }
                completion(newsList)
        }
    }
}
