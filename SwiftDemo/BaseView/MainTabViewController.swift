//
//  MainTabViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/18.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = UITabBarItem.appearance()
        let attrs_Normal = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attrs_Select = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        tabBar.setTitleTextAttributes(attrs_Normal, for: .normal)
        tabBar.setTitleTextAttributes(attrs_Select, for: .selected)
        creatUI()
        
       
    }
    fileprivate func creatUI(){
        setValue(MainTabbar(), forKey: "tabBar")

        let vcArr:[UIViewController] = [FirstViewController(),SocialViewController(),AttentionViewController(),PersonalViewController()];
        let title = [["首页","essence"],["社区","new"],["关注","friendTrends"],["我的","me"]]
        for (index, vc) in vcArr.enumerated() {
            vc.tabBarItem.title = title[index][0]
            vc.tabBarItem.image = UIImage.init(named: "tabBar_\(title[index][1])_icon")
            vc.tabBarItem.selectedImage = UIImage.init(named: "tabBar_\(title[index][1])_click_icon")
            let nav = BaseNavigationController.init(rootViewController: vc)
            addChild(nav)
            
        }
        
    }

   

}
