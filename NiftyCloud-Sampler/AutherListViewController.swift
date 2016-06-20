//
//  AutherListViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/20.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class AutherListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var autherTable: UITableView!
    
    var authers: [Authers] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        autherTable.dataSource = self
        autherTable.delegate = self
        
        autherTable.registerNib(UINib(nibName: "AutherCell", bundle: nil), forCellReuseIdentifier: "AutherCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectAdd() {
        self.transition()
    }
    
    func transition() {
        self.performSegueWithIdentifier("", sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AutherCell") as! AutherCell
        
        return cell
    }
}
