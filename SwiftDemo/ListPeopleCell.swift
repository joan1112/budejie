//
//  ListPeopleCell.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/12.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class ListPeopleCell: UITableViewCell {

    @IBOutlet weak var letfImage: UIImageView!
    
    @IBOutlet weak var descriptionLab: UILabel!
    
    @IBOutlet weak var nameLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
