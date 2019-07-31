//
//  MainTabbar.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/19.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class MainTabbar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(publishButn)

    }
    
    lazy var publishButn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setBackgroundImage(UIImage(named: "tabBar_publish_icon"), for: .normal)
        button.setBackgroundImage(UIImage(named: "tabBar_publish_click_icon"), for: .highlighted)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(clickPublishButton), for: .touchUpInside)
        return button
        
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if zc_height > kTabBarHeight {
            zc_height = kTabBarHeight
        }
        let perwidth = zc_width/5
        let perHeight: CGFloat = 48.0
        let btnY: CGFloat = 0
        var index: CGFloat = 0
        publishButn.center = CGPoint(x:self.zc_centerX , y: (btnY+perHeight/2))
     
        for view in subviews {
            if(view .isKind(of: NSClassFromString("UITabBarButton")!)){
                let buttonx = index<2 ?index:index+1
                view.frame = CGRect(x: buttonx*perwidth, y: btnY, width: perwidth, height: perHeight)
                index += 1
                

            }
        }
        
        
    }
}
extension MainTabbar {
    
    @objc fileprivate func clickPublishButton() {
        
        let publishVC = PublishViewController()
        
        UIApplication.shared.keyWindow?.rootViewController?.present(publishVC, animated: false, completion: nil)
    }
    
}
