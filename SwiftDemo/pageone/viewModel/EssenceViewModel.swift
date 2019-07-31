


//  EssenceViewModel.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/23.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

class EssenceViewModel: NSObject {

    
    class func  loadContent(a:String,type:ContentType,page:Int,finishBlock:@escaping((success:Bool,mTime:String,array:[EseenceModel]))->()
        ) {
        var url = URL(string: "http://e.api.budejie.com/v2/topic/list/1/29680928-29681047/bsbdjhd-iphone-5.1.3/0-25.json")
        if type == .picture{
            url = URL(string: "http://s.budejie.com/v2/topic/list/10/29680706-29679975/bsbdjhd-iphone-5.1.3/0-25.json")
        }else if type == .video{
            url = URL(string: "http://s.budejie.com/v2/topic/list/41/29680214-29667631/bsbdjhd-iphone-5.1.3/0-25.json")
        }else if type == .all{
            url = URL(string: "http://e.api.budejie.com/v2/topic/list/1/29680928-29681047/bsbdjhd-iphone-5.1.3/0-25.json")
        }else if type == .word{
            url = URL(string: "http://s.budejie.com/v2/topic/list/29/29675061-29678776/bsbdjhd-iphone-5.1.3/0-25.json")
        }else{
             url = URL(string: "http://d.api.budejie.com/topic/list/jingxuan/attention/bsbdjhd-iphone-5.1.4/0-20.json?appname=bsbdjhd&asid=89BFC953-C7B2-4694-AD8B-AD1DFCBF1621&client=iphone&device=iPhone8%2C2&from=ios&jbk=0&market=appstore&openudid=aa3f0ea4832e9980b3db5efd149b3d91f8734157&t=1564381786&uid=17181679&ver=5.1.4")
        }
        var parameter = [String: String]()
          parameter["page"] = String(page)
        Alamofire.request(url!, method: .get, parameters: parameter).responseJSON { (response) in
            
            switch response.result{
            case let .success(value):
                guard let dict = value as? [String: Any] else {
                    return
                }
                guard let datas = dict["list"] as? [[String: Any]] else {
                    return
                }
                
                var data = [EseenceModel]()
                for dic in datas {
                    let model:EseenceModel = JSONDeserializer<EseenceModel>.deserializeFrom(dict: dic) ?? EseenceModel()

                    print(model.u?.header[0] ?? "")
                    data.append(model)
                }
                finishBlock((true,"123",data))
                
            case let .failure(Error):
                 let data1 = [EseenceModel]()
                finishBlock((false,"123",data1))

                print("load content \(Error)")
            }
        }
        
    }
}
