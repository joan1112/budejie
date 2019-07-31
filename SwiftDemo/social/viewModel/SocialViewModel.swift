//
//  SocialViewModel.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/29.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON


class SocialViewModel: NSObject {

  class  func getSocialList(finishBlock:@escaping((success:Bool,array:[SocilaModel]))->()) {
         let url1 = URL(string: "http://d.api.budejie.com/forum/subscribe/bsbdjhd-iphone-5.1.4.json")
        Alamofire.request(url1!,method: .get).responseJSON { respnses in
            print(respnses)
            switch respnses.result{
                
            case let .success(value):
                guard let dict = value as? [String:Any] else{
                    return
                }
                guard let list = dict["list"] as? [[String:Any]] else{
                    return
                }
                var data = [SocilaModel]()
                for dic in list{
                    let model1:SocilaModel = JSONDeserializer<SocilaModel>.deserializeFrom(dict: dic) ?? SocilaModel()
                    data.append(model1)
                }
           finishBlock((true,data))
                
            case let .failure(error):
                
                finishBlock((false,[SocilaModel()]))

                
            }
            
        }
    }
}
