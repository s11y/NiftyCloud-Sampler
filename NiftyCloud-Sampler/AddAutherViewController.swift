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
    
    var updateAuther: Authers!
    
    var mode: NCMBCreateType = .Create

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTextField.delegate = TextFieldDelegate()
        familyTextField.delegate = TextFieldDelegate()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if mode == .Update {
            self.displayUpdateAuther()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectSave() {
        guard let str = firstTextField.text else { return }
        guard let text = familyTextField.text else { return }
        switch mode {
        case .Create:
            self.create(str, family: text)
        case .Update:
            self.update(str, family: text)
        }
    }
    
    func displayUpdateAuther() {
        self.firstTextField.text = updateAuther.firstName
        self.familyTextField.text = updateAuther.familyName
    }
    
    func create(first: String, family: String) {
        let auther = Authers.create(first, familyName: family)
        auther.saveWithEvent { 
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func update(first: String, family: String)  {
        Authers.update(updateAuther, firstName: first, familyName: family).saveWithEvent { 
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}
