//
//  PersonalViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/18.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class PersonalViewController: BaseViewController {
//mine-msg-icon  my-post  icon-feedback icon-preview icon-recentHot setting-iconN
    let images:Array = ["mine-icon-preview","mine-my-post","mine-icon-preview","mine-icon-recentHot","mine-icon-feedback","mine-icon-preview"]
    let titles:Array = ["消息","帖子","评论","收藏","意见反馈","设置"]

    
    lazy var personTab:UITableView = {
        let tab = UITableView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-kTabBarHeight), style: .grouped)
        tab.delegate = self
        tab.dataSource = self
        tab.estimatedSectionHeaderHeight = 0
        tab.estimatedSectionFooterHeight = 0
        tab.rowHeight = 70
        return tab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.personTab)
        creatHeader()

    }
    func creatHeader() {
        let head:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height:150))
        self.personTab.tableHeaderView = head
        head.backgroundColor = .white
        let headImg:UIImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 80, height: 80))
        headImg.image = UIImage.init(named: "setup-head-default")
        headImg.layer.cornerRadius = 40
        headImg.layer.masksToBounds = true
        head.addSubview(headImg)

        let lab:UILabel = UILabel.init(frame: CGRect(x: 105, y: 10+5, width: 100, height: 20))
        lab.font = UIFont.systemFont(ofSize: 16)
        head.addSubview(lab)
        lab.text = "tttttaaaannn"
        
        let remark:UILabel = UILabel.init(frame: CGRect(x: 105, y: 40, width: 100, height: 20))
        remark.font = UIFont.systemFont(ofSize: 14)
        remark.textColor = .gray
        head.addSubview(lab)
        remark.text = "nothing to write"
        
        let perwd:CGFloat = (kScreenWidth-20)/4
        let arr:Array = ["获赞","粉丝","关注","等级"]
        for i in 0...3{
            let btn:UIButton = UIButton.init(type: .custom)
            btn.frame = CGRect(x:  CGFloat(i)*perwd, y:100, width: perwd, height: 50)
            
            let labNub = UILabel.init(frame: CGRect(x: 0, y: 0, width: perwd, height: 20))
            labNub.text = "0"
            labNub.font = UIFont.systemFont(ofSize: 14)
            labNub.textColor = .gray
            labNub.textAlignment = .center
            btn.addSubview(labNub)
            
            let lab = UILabel.init(frame: CGRect(x: 0, y: 25, width: perwd, height: 20))
            lab.text = arr[i]
            lab.font = UIFont.systemFont(ofSize: 14)
            lab.textColor = .gray
            lab.textAlignment = .center
            btn.addSubview(lab)
            
            head.addSubview(btn)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    

 

}
extension PersonalViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        
         cell = tableView.dequeueReusableCell(withIdentifier: "cell")
  
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.imageView?.image = UIImage.init(named: images[indexPath.row])
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
