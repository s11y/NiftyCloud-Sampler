//
//  Utility.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/07/04.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

extension UIToolbar {
    func addDoneBtn(target: AnyObject?, textField: UITextField, selector: Selector) {
        self.barStyle = .BlackTranslucent
        self.tintColor = UIColor.whiteColor()
        self.backgroundColor = UIColor.blackColor()
        
        let toolBtn = UIBarButtonItem(title: "DONE", style: .Plain, target: target, action: selector)
        self.items = [toolBtn]
        
        textField.inputAccessoryView = self
    }
}
