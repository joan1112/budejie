//
//  SocialTableViewCell.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/29.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class SocialTableViewCell: UITableViewCell {

    
    @IBOutlet weak var leftImg: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var descripLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
