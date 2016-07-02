//
//  AddAutherViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/07/01.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class AddAutherViewController: UIViewController {
    
    @IBOutlet var firstTextField: UITextField!
    
    @IBOutlet var familyTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTextField.delegate = TextFieldDelegate()
        familyTextField.delegate = TextFieldDelegate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectSave() {
        guard let str = firstTextField.text else { return }
        guard let text = familyTextField.text else { return }
        self.create(str, family: text)
    }
    
    func create(first: String, family: String) {
        let auther = Authers.create(first, familyName: family)
        auther.saveEventually { (error) in
            if error != nil {
                print(error.localizedDescription)
            }else {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
}
