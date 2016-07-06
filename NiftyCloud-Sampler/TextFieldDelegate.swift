//
//  TextFieldDelegate.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/25.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit



class TextFieldDelegate: UIView, UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print(textField)
        textField.resignFirstResponder()
        return true
    }
}
