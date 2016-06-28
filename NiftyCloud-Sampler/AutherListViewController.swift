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
    
    var authers: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        autherTable.dataSource = self
        autherTable.delegate = self
        
        autherTable.registerNib(UINib(nibName: "AutherCell", bundle: nil), forCellReuseIdentifier: "AutherCell")
        self.read()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.read()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectAdd() {
        self.transition()
    }
    
    func read() {
        //        authers = self.loadAll()
        self.loadAll()
        //        autherTable.reloadsData()
        //        self.fetch()
    }
    
    //    func loadAll() -> [Authers] {
    func loadAll()  {
        let query: NCMBQuery = NCMBQuery(className: "Authers")
        
        query.orderByAscending("createDate")
        query.findObjectsInBackgroundWithBlock { (Objects, error) in
            if error == nil {
                print(Objects.count)
            }else {
                print("\(error.localizedDescription)")
            }
        }
        //        query.findObjectsInBackgroundWithBlock { (ncObjects, error) in
        //            if error == nil {
        //                if ncObjects.count > 0 {
        //                    print("\(ncObjects)")
        //                }
        //            }else {
        //                print("\(error.localizedDescription)")
        //            }
        //        }
        //        return authers
    }
    
    func transition() {
        self.performSegueWithIdentifier("toAddAuther", sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AutherCell") as! AutherCell
        
        let auther = authers[indexPath.row]
//        cell.autherLabel.text = "\(auther.familyName) \(auther.firstName)"
        
        return cell
    }
}
