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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, index) in
            self.deleteObject(indexPath: index)
            self.table.deleteRows(at: [index], with: .fade)
        }
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, index) in
            self.updateAuther = self.autherArray[index.row]
        }
        edit.backgroundColor = UIColor.green
        return [delete, edit]
    }
}

extension AutherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "autherCell") as! AutherCell
        let auther = autherArray[indexPath.row]
        cell.nameLabel.text = auther.familyName + auther.firstName
        return cell
    }
}
