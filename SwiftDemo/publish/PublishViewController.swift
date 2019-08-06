//
//  PublishViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/30.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class PublishViewController: UIViewController {

    var imagePicker:UIImagePickerController? = UIImagePickerController()
    @IBOutlet weak var contentText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismissClick(_ sender: Any) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func senderClcik(_ sender: Any) {
        
    }
    
    
    @IBAction func senderVideoAction(_ sender: Any) {
        weak var weakSelf=self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { (statues) in
                switch statues{
                case .notDetermined:self.alert(string: "应用为授权，是否前往授权")
                    break
                case .restricted:self.alert(string: "应用授权被拒绝，是否前往授权")
                    break
                case .authorized:
                    weakSelf!.imagePicker!.delegate = self
                    weakSelf!.imagePicker!.allowsEditing = true

                
                    weakSelf?.imagePicker?.mediaTypes=[kUTTypeMovie as String]//只有视频
                   
//                    weakSelf?.imagePicker?.mediaTypes=UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.photoLibrary)!//包括照片和视频
                    //弹出相册页面或相机
                    self.present( weakSelf!.imagePicker!, animated: true, completion: {
                        
                    })
                    
                    break
                case .denied:self.alert(string: "同意授权")
                default:break
                }
            }
            
        }
    }
    
    @IBAction func addPictureClick(_ sender: Any) {
                weak var weakSelf=self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { (statues) in
                switch statues{
                case .notDetermined:self.alert(string: "应用为授权，是否前往授权")
                    break
                case .restricted:self.alert(string: "应用授权被拒绝，是否前往授权")
                    break
                case .authorized:
                    weakSelf!.imagePicker!.delegate = self
                    weakSelf!.imagePicker!.allowsEditing = true
                    
                                     weakSelf?.imagePicker?.mediaTypes=[kUTTypeImage as String]//只有照片
//                    weakSelf?.imagePicker?.mediaTypes=UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.photoLibrary)!//包括照片和视频
                    //弹出相册页面或相机
                    self.present( weakSelf!.imagePicker!, animated: true, completion: {
                        
                    })
                    
                    break
                case .denied:self.alert(string: "同意授权")
                default:break
                }
            }
            
        }
    }
    
    func alert(string:String)  {
        let alert:UIAlertController = UIAlertController.init(title: "提示", message: string, preferredStyle: .alert)
        let alertAction:UIAlertAction = UIAlertAction.init(title: "取消", style: .cancel) { (act) in
             print("you selected cancel")
        }
        let confirm:UIAlertAction = UIAlertAction.init(title: "确定", style: .default) { (act) in
             print("you selected ok")
            let url=URL.init(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!){
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: { (ist) in
                        
                        
                        UIApplication.shared.openURL(url!)
                        
                    })
                } else {
                    UIApplication.shared.openURL(url!)
                }
            }
                
        }
        alert.addAction(alertAction)
        alert.addAction(confirm)
        
     self.present(alert, animated: true, completion: nil)
        
        
    }
    @IBAction func addAudioClick(_ sender: Any) {
        if#available(iOS 11.0, *){
            let cust = CustcarmeViewController()
            
            self.present(cust, animated: true, completion: nil)
            
        }else{
            
        }

        
    }
   

}

extension PublishViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let type = info[UIImagePickerController.InfoKey.mediaType]
    }
}
