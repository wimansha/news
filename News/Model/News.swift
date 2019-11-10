//
//  News.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/9/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit

class News {
    
    let title : String
    var description : String?
    var author : String?
    var imgUrl : URL?
    var originlNewsUrl : URL?
    
    init?(jsonData : [String : Any]) {
        guard let title = jsonData["title"] as? String else{
            return nil
        }
        self.title = title
        
        if let description = jsonData["description"] as? String{
            self.description = description
        }
        
        if let imgUrlString = jsonData["urlToImage"] as? String{
            self.imgUrl = URL(string: imgUrlString)
        }
        
        if let origNewsUrlString = jsonData["url"] as? String{
            self.originlNewsUrl = URL(string: origNewsUrlString)
        }
        
        if let author = jsonData["author"] as? String{
            self.author = author
        }
        
    }
}
