//
//  StageTableCell.swift
//  Code Burger
//
//  Created by Qiarra on 15/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import UIKit

class StageTableCell: UITableViewCell {
    @IBOutlet weak var imgStage: UIImageView!
    @IBOutlet weak var lblStage: UILabel!
    @IBOutlet weak var imgLock: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        imgStage.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.5)
    }
}
