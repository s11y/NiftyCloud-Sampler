
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
        self.barStyle = .blackTranslucent
        self.tintColor = UIColor.white
        self.backgroundColor = UIColor.black
        
        let toolBtn = UIBarButtonItem(title: "DONE", style: .plain, target: target, action: selector)
        self.items = [toolBtn]
        
        textField.inputAccessoryView = self
    }
}
