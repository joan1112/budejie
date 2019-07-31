//
//  PublishViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/30.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {

    
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
        
    }
    
    @IBAction func addPictureClick(_ sender: Any) {
        
    }
    
    @IBAction func addAudioClick(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
