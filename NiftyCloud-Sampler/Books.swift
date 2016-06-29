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
    
    var 
    
    
    
    override init!(className: String!) {
        super.init(className: className)
    }
    static func ncmbClassName() -> String! {
        return "Books"
    }
}