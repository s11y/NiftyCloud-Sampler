//
//  AutherListViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/30.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class AutherListViewController: UIViewController  {
    
    @IBOutlet var table: UITableView!
    
    var autherArray: [Authers] = []
    
    var updateAuther: Authers!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        table.registerNib(UINib(nibName: "AutherCell", bundle: nil), forCellReuseIdentifier: "autherCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.read()
        
        table.estimatedRowHeight = 30
        table.rowHeight = UITableViewAutomaticDimension
        table.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func read() {
        Authers.loadAll { (objects) in
            self.autherArray = objects
            self.table.reloadData()
        }
    }
    
    func deleteObject(indexPath: NSIndexPath) {
        let object = autherArray[indexPath.row]
        object.deleteEventually { (error) in
            if error != nil {
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAddAutherView" {
            let viewController = segue.destinationViewController as! AddAutherViewController
            viewController.updateAuther = self.updateAuther
            viewController.mode = .Update
        }
    }
}
