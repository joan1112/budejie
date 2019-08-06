//
//  SocialViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/18.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit
import Kingfisher
class SocialViewController: BaseViewController {

    var dataArr:[SocilaModel]?
    
    lazy var listTab:UITableView = {
        let tab = UITableView.init(frame: CGRect(x: 0, y:0 , width: kScreenWidth, height: kScreenHeight-kTabBarHeight), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.rowHeight = 90
//        UINib *nib = [UINib nibWithNibName:@"MyCollectionCell"
//            bundle: [NSBundle mainBundle]];
        tab.register(UINib.init(nibName: "SocialTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        return tab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "社区"
        self.view.addSubview(self.listTab)
        headView()

        SocialViewModel.getSocialList(){(success,data) in
           self.dataArr = data
            print(data)
            self.listTab.reloadData()
        }
            
        
        
    }

    func headView(){
        let head = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
        self.listTab.tableHeaderView = head
        let sdcroll:SDCycleScrollView = SDCycleScrollView.init(frame:head.frame)
        head.addSubview(sdcroll)
        sdcroll.delegate = self
        sdcroll.imageURLStringsGroup = ["http://wimg.spriteapp.cn/picture/2019/0627/5d14a2231dea5_wpd.jpg","http://wimg.spriteapp.cn/picture/2019/0627/5d14cf55d2ec0_wpd.jpg"]
    }
    

    

}

extension SocialViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell:SocialTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SocialTableViewCell
        
   
           let model = self.dataArr?[indexPath.row]
        cell.leftImg.kf.setImage(with: URL(string: model?.image_list ?? ""))
        
        cell.titleLab.text = model?.theme_name ?? ""
        cell.descripLab.text = model?.info ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
extension SocialViewController:SDCycleScrollViewDelegate{
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
    }
}
