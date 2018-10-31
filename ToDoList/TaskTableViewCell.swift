//
//  TaskTableViewCell.swift
//  AV2Ios
//
//  Created by administrador on 23/10/2018.
//  Copyright © 2018 administrador. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priority: UIView!
    @IBOutlet weak var name: UILabel!
    var status:Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


