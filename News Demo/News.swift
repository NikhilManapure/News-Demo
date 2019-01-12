//
//  News.swift
//  News Demo
//
//  Created by Evolusolve on 12/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

import Foundation


class News {
    var title: String?
    var description: String?
    var content: String?
    var url: String?
    var imageUrl: String?
    var date: String?
    var author: String?
    
    init?(raw: [String: Any]) {
        title = raw["title"] as? String
        description = raw["description"] as? String
        content = raw["content"] as? String
        url = raw["url"] as? String
        imageUrl = raw["urlToImage"] as? String
        author = raw["author"] as? String
        
        if let dateString = raw["publishedAt"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "dd-MMM-YY"
                self.date = dateFormatter.string(from: date)
            }
        }
    }
}
