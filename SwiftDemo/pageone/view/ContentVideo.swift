//
//  ContentVideo.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/24.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class ContentVideo: UIView {

    @IBOutlet weak var videoImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    public static func video() -> ContentVideo {
        let view = Bundle.main.loadNibNamed("ContentVideo", owner: nil, options: nil)?.first as! ContentVideo
        return view
    }

}
