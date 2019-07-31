//
//  ContentTableViewCell.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/24.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
class ContentTableViewCell: UITableViewCell {

    var head:UIImageView = UIImageView()
    var userNameLab:UILabel = UILabel()
    var content:UILabel = UILabel()
    
    //
    var contentImg:PictureView = PictureView.picture()
    var contentVideo:ContentVideo = ContentVideo.video()
    var footView:FootView = FootView.footview()
    var model: EseenceModel!

    var imgShowData:((_:EseenceModel)->Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        content.numberOfLines = 0
        head.layer.cornerRadius = 25
        head.layer.masksToBounds = true
        content.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(head)
        self.contentView.addSubview(userNameLab)
        self.contentView.addSubview(content)
        self.contentView.addSubview(contentImg)
        self.contentView.addSubview(contentVideo)
        self.contentView.addSubview(footView)
        
        contentImg.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(showBigPicture)))
        
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        loadUI()
    }

    func loadUI(){
        
        
        userNameLab.text = model.u?.name
        content.text = model.text
        head.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.top.equalTo(self.contentView).offset(10)
            make.width.height.equalTo(50)
        }
        
        if let images = model.u?.header[0]{
            head.kf.setImage(with: URL(string: images))
            
        }
        
        userNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(head.snp_right).offset(10)
            make.centerY.equalTo(self.head.snp_centerY)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
        }
        content.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left).offset(10)
            make.top.equalTo(self.head.snp_bottom).offset(5)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
        }
        if model.type == "gif" {
            contentVideo.isHidden = true
            contentImg.isHidden = false
            if let images = model.gif?.images[0]{
                contentImg.pictureImg.kf.setImage(with: URL(string: images))

            }
            contentImg.frame = model.pictureFrame
            footView.frame  = CGRect(x: 10, y: model.cellHeight-50, width: kScreenWidth-20, height: 50)

//            contentImg.snp.makeConstraints { (make) in
//                make.left.equalTo(self.contentView.snp_left).offset(10)
//                make.top.equalTo(self.content.snp_bottom).offset(10)
//                make.right.equalTo(self.contentView.snp_right).offset(-10)
//            }
//            footView.snp.makeConstraints { (make) in
//                make.left.equalTo(self.contentView.snp_left).offset(10)
//                make.top.equalTo(self.contentImg.snp_bottom).offset(10)
//                make.right.equalTo(self.contentView.snp_right).offset(-10)
//                make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
//            }
        }else if model.type == "video"{
            contentImg.isHidden = true
            contentVideo.isHidden = false
            if let images = model.video?.thumbnail[0]{
                print("------\(images)")
                contentVideo.videoImg.kf.setImage(with: URL(string: images))
                
            }
            contentVideo.frame = model.videoFrame
            footView.frame  = CGRect(x: 10, y: model.cellHeight-50, width: kScreenWidth-20, height: 50)
           
//            contentVideo.snp.makeConstraints { (make) in
//                make.left.equalTo(self.contentView.snp_left).offset(10)
//                make.top.equalTo(self.content.snp_bottom).offset(10)
//                make.right.equalTo(self.contentView.snp_right).offset(-10)
//            }
//            footView.snp.makeConstraints { (make) in
//                make.left.equalTo(self.contentView.snp_left).offset(10)
//                make.top.equalTo(self.contentVideo.snp_bottom).offset(10)
//                make.right.equalTo(self.contentView.snp_right).offset(-10)
//                make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
//            }

        }else if model.type == "image"{
            contentVideo.isHidden = true
            contentImg.isHidden = false
            if let images = model.image?.thumbnail_picture[0]{
                contentImg.pictureImg.kf.setImage(with: URL(string: images))
                
            }
            
            contentImg.frame = model.pictureFrame
            footView.frame  = CGRect(x: 10, y: model.cellHeight-50, width: kScreenWidth-20, height: 50)
//            contentImg.snp.makeConstraints { (make) in
//                make.left.equalTo(self.contentView.snp_left).offset(10)
//                make.top.equalTo(self.content.snp_bottom).offset(10)
//                make.right.equalTo(self.contentView.snp_right).offset(-10)
//            }
//
//            footView.snp.makeConstraints { (make) in
//                make.left.equalTo(self.contentView.snp_left).offset(10)
//                make.top.equalTo(self.contentImg.snp_bottom).offset(10)
//                make.right.equalTo(self.contentView.snp_right).offset(-10)
//                make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
//            }

        }else{
            contentImg.isHidden = true
            contentVideo.isHidden = true
//            footView.snp.makeConstraints { (make) in
//                make.left.equalTo(self.contentView.snp_left).offset(10)
//                make.top.equalTo(self.content.snp_bottom).offset(10)
//                make.right.equalTo(self.contentView.snp_right).offset(-10)
//                make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
//            }
            footView.frame  = CGRect(x: 10, y: model.cellHeight-50, width: kScreenWidth-20, height: 50)

        }
        
    }
    
    
   @objc func showBigPicture(){
         
        imgShowData!(model)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
