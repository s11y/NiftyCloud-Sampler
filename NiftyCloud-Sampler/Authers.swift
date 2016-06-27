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
    
    override init() {
        super.init()
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
        let auther = Authers(className: "Authers")
        auther.firstName = text
        auther.familyName = str
        return auther
        
    }
    
    func saveWithEvent() {
        self.saveEventually { (error) in
            if error != nil {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    static func ncmbClassName() -> String! {
        return "Authers"
    }

}
