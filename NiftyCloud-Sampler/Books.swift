//
//  Books.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/19.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class Books: NCMBObject, NCMBSubclassing {
    @NSManaged var title: String!
    @NSManaged var auther: String!
    @NSManaged var publishedDate: NSDate!
    
    init(title: String, publishedDate: NSDate, auther: String) {
        super.init()
        self.title = title
        self.auther = auther
        self.publishedDate = publishedDate
    }
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func ncmbClassName() -> String! {
        return "Books"
    }
    
    static func loadAll() -> [Books] {
        var books: [Books] = []
        let query = NCMBQuery(className: self.ncmbClassName())
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                for book in objects {
                    books.append(book as! Books)
                }
            }else {
                print("\(error.localizedDescription)")
            }
        }
        return books
    }
}
