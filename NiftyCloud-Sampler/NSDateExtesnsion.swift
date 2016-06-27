//
//  NSDateExtesnsion.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/25.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

extension NSDate {
    func convert() -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.stringFromDate(self)
    }
}
