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
    
    override init!(className: String!) {
        super.init(className: className)
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
        let book = Books(className: "Books")
        book.title = title
        book.publishedDate = date
        book.auther = auther
        book.isPublic = isPublic
        book.user = user
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
                print("objects...\(objects)")
                for object in objects {
//                    books.append(book as! Books)
                    if let book: Books = object as? Books {
                        books.append(book)
                    }
                }
            }else {
                print("\(error.localizedDescription)")
            }
        }
        return books
    }
    

}
