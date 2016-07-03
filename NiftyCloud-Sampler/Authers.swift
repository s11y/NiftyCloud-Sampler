//
//  Authers.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/30.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation
import NCMB

@objc(Authers)
class Authers: NCMBObject, NCMBSubclassing {
    
    var familyName : String {
        get {
            return objectForKey("familyName") as! String
        }
        set {
            setObject(newValue, forKey: "familyName")
        }
    }
    
    var firstName: String {
        get {
            return objectForKey("firstName") as! String
        }set {
            setObject(newValue, forKey: "firstName")
        }
    }
    
    static func create(firstName: String, familyName: String) -> Authers {
        let auther = Authers(className: "Authers")
        auther.familyName = familyName
        auther.firstName = firstName
        return auther
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
    
    static func loadAll(callback: (objects: [Authers]) -> Void) {
        let query = NCMBQuery(className: "Authers")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                print(error.localizedDescription)
            }else {
                let obj = objects as! [Authers]
                print(obj)
                callback(objects: obj)
            }
        }
    }
    
    override init!(className: String!) {
        super.init(className: "Authers")
    }
    
    static func ncmbClassName() -> String! {
        return "Authers"
    }
}