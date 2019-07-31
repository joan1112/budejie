//
//  EseenceModel.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/23.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit
import HandyJSON
class EseenceModel: HandyJSON {

    //文字
    var text:String = ""
    var up:Int = 0
//4 gif
    var status:Int = 0
    var down:Int = 0
    var forward:Int = 0
    var rating:String = ""
    var name:String = ""
    var passtime:String = ""
    var id:String = ""
    var type:String = ""
    var comment:String = ""

    //视频
    var video:VedioModel?
    //动画
    var gif:VedioModel?
    //图片
    var image:VedioModel?
    var u:UserMessageModel?

    var tags:Array<Dictionary<String,Any>> = [[:]]
    
    
    var pictureFrame: CGRect!
    var voiceFrame: CGRect!
    var videoFrame: CGRect!
    var _cellHeight: CGFloat = 0

    required init() {}
    
    var cellHeight: CGFloat{
        get{
            if _cellHeight==0 {
                var size = CGSize(width: kScreenWidth-kCellTextMargin*2, height: 10000)
                size = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], context: nil).size
                _cellHeight = kCellHeaderHeight + size.height + kCellFooterHeight + 2 * kCellTextMargin
                if type=="gif"{
                    let pictureW: CGFloat = kScreenWidth - kCellTextMargin * 2;
                    // 显示显示出来的高度
                    var pictureH: CGFloat = pictureW * gif!.thumbnail_height / gif!.thumbnail_width;
                    
                    if pictureH >= kCellIamgeMaxH {
                        pictureH = kCellImageBreakHeight
//                        isBigPicture = true
                    }
                    
                    pictureFrame = CGRect(x: kCellTextMargin, y: kCellHeaderHeight + size.height + 2 * kCellTextMargin , width: pictureW, height: pictureH)
                    _cellHeight += (pictureH + kCellTextMargin)
                }else if type == "image"{
                    let pictureW: CGFloat = kScreenWidth - kCellTextMargin * 2;
                    // 显示显示出来的高度
                    var pictureH: CGFloat = pictureW * image!.thumbnail_height / image!.thumbnail_width;
                    
                    if pictureH >= kCellIamgeMaxH {
                        pictureH = kCellImageBreakHeight
                        //                        isBigPicture = true
                    }
                    
                    pictureFrame = CGRect(x: kCellTextMargin, y: kCellHeaderHeight + size.height + 2 * kCellTextMargin , width: pictureW, height: pictureH)
                    _cellHeight += (pictureH + kCellTextMargin)
                }else if type == "video"{
                    let pictureW: CGFloat = kScreenWidth - kCellTextMargin * 2;
                    // 显示显示出来的高度
                    let pictureH: CGFloat = pictureW * video!.thumbnail_height / video!.thumbnail_width;
                    
                    videoFrame = CGRect(x: kCellTextMargin, y: kCellHeaderHeight + size.height + 2 * kCellTextMargin , width: pictureW, height: pictureH)
                    _cellHeight += (pictureH + kCellTextMargin)
                }
       
                
            }
            return _cellHeight
            
            
        }
        
    }
    
    
    
    
    
}

class VedioModel:HandyJSON{
    var thumbnail_height:CGFloat = 0
    var height:CGFloat = 0
    var width:CGFloat = 0
    var thumbnail_width:CGFloat = 0


    var video:Array<String> = [""]
    var download:Array<String> = [""]
    var download_url:Array<String> = [""]
    var big:Array<String> = [""]

    var duration:CGFloat = 0
    var thumbnail:Array<String> = [""]
    var thumbnail_small:Array<String> = [""]
    var images:Array<String> = [""]
    var thumbnail_picture:Array<String> = [""]

    
     required init() {}
    
}

class UserMessageModel:HandyJSON{
     var header:Array<String> = [""]
    var relationship:Int = 0
    var uid:String = ""
    var name:String = ""
    
    
    
    
    
    required init() {}
}
