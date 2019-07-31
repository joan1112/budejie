//
//  BaseNavigationController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/30.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = .white
       let arr = self.navigationBar.subviews
        print("uuuuu\(arr)")
        

    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.setNavigationBarHidden(false, animated: true)
        if self.viewControllers.count>1{
            let left:UIBarButtonItem = UIBarButtonItem.init(title: "backs", fontSize: 16, self, #selector(back))
            self.navigationItem.leftBarButtonItem = left
        }
    }

    
    @objc func back()  {
        self.navigationController?.popViewController(animated: true)
        
    }

}
