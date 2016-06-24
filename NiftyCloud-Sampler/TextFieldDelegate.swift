//
//  TextFieldDelegate.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/25.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject ,UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
