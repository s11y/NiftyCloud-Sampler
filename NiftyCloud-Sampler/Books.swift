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
    
    
    
    override init!(className: String!) {
        super.init(className: className)
    }
    
    static func ncmbClassName() -> String! {
        return "Books"
    }
}