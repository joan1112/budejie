//
//  FirstViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/18.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {


    let titles = ["推荐","视频","图片","笑话","娱乐"]
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var contentView: UIScrollView = {
        let contentView = UIScrollView.init(frame: CGRect(x: 0, y:kTopHeight , width: kScreenWidth, height: view.zc_height-kTopHeight-kTabBarHeight))
        contentView.layer.zPosition = 1
        contentView.isPagingEnabled = true
        contentView.delegate = self
        self.view.addSubview(contentView)
        contentView.bounces = false
        contentView.contentSize = CGSize(width: kScreenWidth * CGFloat(titles.count), height: contentView.zc_height)
        return contentView
    }()
    var currentButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()

        creatTitleView()
        
        if #available(iOS 11.0, *) {
            contentView.contentInsetAdjustmentBehavior = .never
        }else{
            
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    


}
extension FirstViewController{
    
    fileprivate func creatTitleView(){
    
        let titleView = UIView.init(frame: CGRect(x: 0, y: 0, width: view.zc_width, height:kTopHeight))
        titleView.backgroundColor = UIColor.white
        titleView.layer.zPosition = 2
        titleView.isUserInteractionEnabled = true
        self.view.addSubview(titleView)
        let perWd:CGFloat = view.zc_width/6
        let perHeight:CGFloat = 42.0
        let yy = kStatusBarHeight
        for i in 0..<titles.count{
            let btn:UIButton = UIButton.init(type: .custom)
            btn.frame = CGRect(x:CGFloat(i) * perWd , y: yy, width: perWd, height: perHeight)
            btn.setTitle(titles[i], for: .normal)
            btn.setTitleColor(.gray, for: .normal)
            btn.titleLabel?.textAlignment = .center
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.addTarget(self, action: #selector(clickTitleView(_:)), for: .touchUpInside)
            titleView.addSubview(btn)
            btn.tag = 10+i
            if i==0 {
                btn.titleLabel?.sizeToFit()
                self.bottomView.frame = CGRect(x: 0, y: 0, width: btn.titleLabel!.zc_width, height: 2)
                self.bottomView.center = CGPoint(x: btn.center.x, y:btn.zc_bottom + 1)
                titleView.addSubview(bottomView)
                clickTitleView(btn)
                let vc = children[Int(0)]
                vc.view.frame = CGRect(x: 0, y: 0, width: contentView.zc_width, height: contentView.zc_height)
                contentView.addSubview(vc.view)
                
            }
            
        }
        //Configure your device to use Charles as its HTTP proxy on 172.2.0.83:8888, then browse to chls.pro/ssl to download and install the certificate.
        let search:UIButton = UIButton.init(type: .custom)
        search.setImage(UIImage.init(named: "search"), for: .normal)
        search.frame = CGRect(x: perWd * CGFloat(titles.count), y: yy-8, width: perWd, height: 40)
        
        titleView.addSubview(search)
        
        
        
        
        
        
    }
    @objc fileprivate func clickTitleView(_ sender:UIButton){
        currentButton = sender
        UIView.animate(withDuration: 0.5) {
            self.bottomView.frame = CGRect(x: 0, y: 0, width: self.currentButton.titleLabel!.zc_width, height: 2)
            self.bottomView.center = CGPoint(x: self.currentButton.center.x, y:self.currentButton.zc_bottom + 1)
        }
        
        var offSet = contentView.contentOffset
        offSet.x = CGFloat(sender.tag - 10) * contentView.zc_width
        contentView.setContentOffset(offSet, animated: true)
    }
    
}
extension FirstViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        let index = scrollView.contentOffset.x / scrollView.zc_width
        clickTitleView(view.viewWithTag(10 + Int(index)) as! UIButton)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.zc_width
        let vc = children[Int(index)]
        vc.view.frame = CGRect(x: index * contentView.zc_width, y: 0, width: contentView.zc_width, height: contentView.zc_height)
        contentView.addSubview(vc.view)
    }
}


extension FirstViewController {
    func setupChildViewControllers() {
        for i in 0..<5 {
            let vc = EssenceChildViewController()
            switch i {
            case 0:
                vc.typeCC = .all
            case 1:
                vc.typeCC = .video
            case 2:
                vc.typeCC = .picture
            case 3:
                vc.typeCC = .word

            default:
                vc.typeCC = .all
            }
            addChild(vc)
        }
    }
}
