//
//  Books.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/30.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation
import NCMB

@objc(Books)
class Books: NCMBObject, NCMBSubclassing {
    
    var title: String! {
        get {
            return objectForKey("title") as! String
        }
        set {
            setObject(newValue, forKey: "title")
        }
    }
    
    var publishedDate: NSDate {
        get {
            return objectForKey("publishedDate") as! NSDate
        }
        set {
            setObject(newValue, forKey: "publishedDate")
        }
    }
    
    var isPublic: Int {
        get {
            return objectForKey("isPublic") as! Int
        }
        set {
            setObject(newValue, forKey: "isPublic")
        }
    }
    
    var user: NCMBUser {
        get {
            return objectForKey("user") as! NCMBUser
        }
        set {
            setObject(newValue, forKey: "user")
        }
    }
    
    var auther: Authers {
        get {
            return objectForKey("auther") as! Authers
        }
        set {
            setObject(newValue, forKey: "auther")
        }
    }
    
    override init!(className: String!) {
        super.init(className: className)
    }
    
    static func create(title: String, date: NSDate, isPublic: Int, user: NCMBUser, auther: Authers) -> Books{
        let book = Books(className: "Books")
        book.auther = auther
        book.isPublic = isPublic
        book.title = title
        book.user = user
        book.publishedDate = date
        return book
    }
    
    static func update(object: Books, user: NCMBUser, title: String, date: NSDate, isPublic: Int, auther: Authers) -> Books{
        if object.user == user {
            object.title = title
            object.auther = auther
            object.isPublic = isPublic
            object.publishedDate = date
        }
        return object
    }
    
    static func loadAll(callback: (objects: [Books]) -> Void) {
        let query = NCMBQuery(className: "Books")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                print(error.localizedDescription)
            }else {
                let obj = objects as! [Books]
                print(obj)
                callback(objects: obj)
            }
        }
    }
    
    func saveWithEvent(callback: () -> Void) {
        self.saveEventually { (error) in
            if error != nil {
                print(error.localizedDescription)
            }else {
                callback()
            }
        }
    }
    
    static func ncmbClassName() -> String! {
        return "Books"
    }
}