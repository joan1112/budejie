//
//  SocilaModel.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/29.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit
import HandyJSON
class SocilaModel: HandyJSON {
    var info:String = ""
    var theme_name:String = ""
    var image_list:String = ""
    var image_detail:String = ""
    var tail:String = ""

    var visit:Int = 0
    var post_num:Int = 0
    var colum_set:Int = 0
    var sub_number:Int = 0
    var theme_id:Int = 0
    required init() {
        
    }

}
