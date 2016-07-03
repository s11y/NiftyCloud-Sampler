//
//  AutherListExtension.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/07/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation
import UIKit

extension AutherListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Default, title: "Delete") { (action, index) in
            self.deleteObject(index)
            self.table.deleteRowsAtIndexPaths([index], withRowAnimation: .Fade)
        }
        
        let edit = UITableViewRowAction(style: .Default, title: "Edit") { (action, index) in
            
        }
        edit.backgroundColor = UIColor.greenColor()
        return [delete, edit]
    }
}

extension AutherListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autherArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("autherCell") as! AutherCell
        let auther = autherArray[indexPath.row]
        cell.nameLabel.text = auther.familyName + auther.firstName
        return cell
    }
}