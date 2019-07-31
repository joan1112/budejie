//
//  PictureView.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/24.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class PictureView: UIView {
   
    
    @IBOutlet weak var pictureImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    public static func picture() -> PictureView {
        let view = Bundle.main.loadNibNamed("PictureView", owner: nil, options: nil)?.first as! PictureView
        return view
    }
}
