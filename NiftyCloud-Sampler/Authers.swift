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
    
    override init!(className: String!) {
        super.init(className: "Authers")
    }
    
    static func ncmbClassName() -> String! {
        return "Authers"
    }
}