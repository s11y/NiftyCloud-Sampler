//
//  BookCell.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/19.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var publishedDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(isSelected, animated: animated)

        // Configure the view for the selected state
    }
    
}
