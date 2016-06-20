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
    
    init(firstName: String, familyName: String) {
        super.init()
        self.familyName = familyName
        self.firstName = firstName
    }
    
    override init() {
        super.init()
    }
    
    static func create(firstName first: String, familyName family: String) {
        let auther = Authers(firstName: first, familyName: family)
        auther.saveEventually { (error) in
            if error != nil {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    static func loadAll() -> [Authers] {
        var authers: [Authers] = []
        let query = NCMBQuery(className: self.ncmbClassName())
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                print("\(error.localizedDescription)")
            }else {
                for object in objects {
                    authers.append(object as! Authers)
                }
            }
        }
        return authers
    }
    
    static func ncmbClassName() -> String! {
        return "Authers"
    }

}
