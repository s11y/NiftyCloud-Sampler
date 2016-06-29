//
//  Authers.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/19.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class Authers: NCMBObject, NCMBSubclassing {
    
    @NSManaged var familyName: String!
    @NSManaged var firstName: String!
    
    override init!(className: String!) {
        super.init(className: className)
    }
    
    static func loadAll() -> [Authers] {
        var authers: [Authers] = []
        let query = NCMBQuery(className: "Authers")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                print("\(error.localizedDescription)")
            }else {
                print("\(objects)")
            }
        }
        return authers
    }
    
    static func create(first text: String, family str: String) -> Authers {
        let auther = Authers(className: self.ncmbClassName())
        auther.setObject(text, forKey: "firstName")
        auther.setObject(str, forKey: "familyName")
        return auther
        
    }
    
    func saveWithEvent() {
        self.saveEventually { (error) in
            if error != nil {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func saveInBackground() {
        self.saveInBackgroundWithBlock { (error) in
            if error != nil {
                print(error.localizedDescription)
            }
        }
    }
    
    static func ncmbClassName() -> String! {
        return "Authers"
    }

}
