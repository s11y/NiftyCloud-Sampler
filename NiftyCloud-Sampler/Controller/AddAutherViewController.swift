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
        
        firstTextField.delegate = self
        familyTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if mode == .Update {
            self.displayUpdateAuther()
        }
    }
    
    @IBAction func didSelectSave() {
        guard let str = firstTextField.text else { return }
        guard let text = familyTextField.text else { return }
        switch mode {
        case .Create:
            self.create(first: str, family: text)
        case .Update:
            self.update(first: str, family: text)
        }
    }
    
    func displayUpdateAuther() {
        self.firstTextField.text = updateAuther.firstName
        self.familyTextField.text = updateAuther.familyName
    }
    
    func create(first: String, family: String) {
        let auther = Authers.create(firstName: first, familyName: family)
        auther.saveWithEvent { 
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func update(first: String, family: String)  {
        Authers.update(object: updateAuther, firstName: first, familyName: family).saveWithEvent { 
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
