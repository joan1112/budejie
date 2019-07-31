//
//  FootView.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/24.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class FootView: UIView {

    
    @IBOutlet weak var zanBtn: UIButton!
    @IBOutlet weak var caiBtn: UIButton!
    
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    public static func footview() -> FootView {
        let view = Bundle.main.loadNibNamed("FootView", owner: nil, options: nil)?.first as! FootView
        return view
    }
    @IBAction func zanClick(_ sender: Any) {
    }
    
    @IBAction func caiClick(_ sender: Any) {
    }
    
    
    @IBAction func commentClcik(_ sender: Any) {
    }
    
    
    
    @IBAction func shareClick(_ sender: Any) {
    }
    
    
    
    
}
