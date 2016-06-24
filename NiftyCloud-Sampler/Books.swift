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
    @NSManaged var auther: Authers!
    @NSManaged var publishedDate: NSDate!
    @NSManaged var isPublic: NSNumber!
    @NSManaged var user: NCMBUser!
    
    init(title: String, publishedDate: NSDate, auther: Authers, isPublic: NSNumber, user: NCMBUser) {
        super.init()
        self.title = title
        self.auther = auther
        self.publishedDate = publishedDate
        self.isPublic = isPublic
        self.user = user
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
    
    static func create(titleOfBook title: String, publishedDate date: NSDate, autherOfBook auther: Authers, isPublic: NSNumber, user: NCMBUser) -> Books {
        let book = Books(title: title, publishedDate: date, auther: auther, isPublic: isPublic, user: user)
        return book
    }
    
    func saveWithEvent(){
        self.saveEventually { (error) in
            if error != nil {
                print("\(error.localizedDescription)")
            }
        }
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
