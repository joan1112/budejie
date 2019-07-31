//
//  ShowImageView.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/26.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class ShowImageView: UIView {

    var outFrame = CGRect.zero
    var insideFrame = CGRect.zero

    lazy var blackBgView:UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        view.isUserInteractionEnabled = true
        view.alpha = 0
        view.backgroundColor = UIColor.black
        
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapAction)))
        return view
    }()
    
    
    lazy var showImg:UIImageView = {
        var img = UIImageView.init()
        img.contentMode = .scaleAspectFit
        
        
        return img
    }()
    
    lazy var bgScroll:UIScrollView = {
        let scrol = UIScrollView.init()
        
        return scrol
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.blackBgView)
        blackBgView.addSubview(self.bgScroll)
        bgScroll.addSubview(self.showImg)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   @objc func tapAction(){
    self.blackBgView.isUserInteractionEnabled = false
    UIView.animate(withDuration: 0.3, animations: {
        self.showImg.frame = self.outFrame
        self.blackBgView.alpha = 0
    }) { (finished) in
        self.blackBgView.isUserInteractionEnabled = true
        self.removeFromSuperview()
     }
    }
    
    func show(model:EseenceModel) {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.blackBgView.alpha = 0
       
        self.showImg.frame = outFrame
        UIView.animate(withDuration: 0.4, animations: {
            self.bgScroll.frame = self.blackBgView.frame
             self.blackBgView.alpha = 1
            let pictureW: CGFloat = kScreenWidth;
            // 显示显示出来的高度
           var pictureH: CGFloat
            if model.type == "gif"{
                 pictureH = pictureW * model.gif!.height / model.gif!.width;
                self.showImg.kf.setImage(with: URL(string: model.gif?.images[0] ?? ""), placeholder: UIImage(named: "11"), options: [
                    
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                    ], progressBlock: { (progess, progess1) in
                        print("33\(progess)\(progess1)")
                }, completionHandler: { (img, error, cach, url) in
                    print("22\(String(describing: img))")
                    
                })
            }else{
                pictureH = pictureW * model.image!.height / model.image!.width;
                self.showImg.kf.setImage(with: URL(string: model.image?.big[0] ?? ""), placeholder: UIImage(named: "11"), options: [
                    
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                    ], progressBlock: { (progess, progess1) in
                        print("33\(progess)\(progess1)")
                }, completionHandler: { (img, error, cach, url) in
                    print("22\(String(describing: error))")
                    
                })
            }
           
            self.bgScroll.contentSize = CGSize(width: kScreenWidth, height: pictureH)
           var centerY:CGFloat = pictureH/2
            if pictureH<kScreenHeight{
                centerY = kScreenHeight/2
            }
            self.showImg.center = CGPoint(x:kScreenWidth/2 , y: centerY)
                self.showImg.bounds = CGRect(x: 0, y: 0, width: kScreenWidth, height: pictureH)
            
            
        }, completion: nil)
    }
    

}
