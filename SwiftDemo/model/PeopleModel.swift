//
//  PeopleModel.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/12.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class PeopleModel: NSObject {
    let name:String
    let bio:String
    let image:String
    let works:[Work]
    
    
    
    

    
    init(name:String,bio:String,image:String,works:[Work]) {
        self.name=name;
        self.bio=bio;
        self.image = image;
        self.works = works;
    }
    
  static  func getData() -> [PeopleModel] {
        var datas = [PeopleModel]()
        guard let url = Bundle.main.url(forResource: "artists", withExtension: "json") else {
            return datas;
        }
        
        do{
            let pp = try Data(contentsOf: url)
            guard let rootObject = try JSONSerialization.jsonObject(with: pp, options: .allowFragments) as? [String : Any]  else {
                return datas
            }
            
            guard let artList = rootObject["artists"] as? [[String : AnyObject]] else {
                return datas
            }
            
          
            
            for artist in artList {
              if  let name = artist["name"] as? String,
                let bio = artist["bio"] as? String,
                let image = artist["image"] as? String,
                let wws = artist["works"] as? [[String : String]] {
                var works = [Work]()
                    for workObject in wws {
                        if let workTitle = workObject["title"],
                            let workImageName = workObject["image"],
                            let info = workObject["info"] {
                            works.append(Work(title: workTitle,image: workImageName,info: info, isExpanded: false))
                        }
                    }
                    let artist = PeopleModel(name: name, bio: bio, image: image, works: works)
                    datas.append(artist)

                }
                
            }
            
        }catch{
            return datas;
        }
        return datas;
    }
    
}

class Work: NSObject {
    let title:String
    let image:String
    let info:String
    let isExpanded:Bool
    
    init(title:String,image:String,info:String, isExpanded:Bool) {
        self.title = title;
        self.image=image
        self.info = info
        self.isExpanded = isExpanded;
    }
}
