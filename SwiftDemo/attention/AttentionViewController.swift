//
//  AttentionViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/18.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class AttentionViewController: BaseViewController {

    var dataArr:[EseenceModel]! = []
    
    lazy var listTab:UITableView = {
        let tab = UITableView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-kTabBarHeight))
        tab.delegate = self
        tab.dataSource = self
        tab.register(ContentTableViewCell.self, forCellReuseIdentifier: "cell")
        return tab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "关注"
        
        self.view.addSubview(self.listTab)
        creatHeader()
        requestData()
      
    }
    func requestData()  {
        EssenceViewModel.loadContent(a: "1", type: .voice, page: 1) { (sucess,mtime,array) in
            
                            self.dataArr = array
            
                        self.listTab.reloadData()
        }
    }
    func creatHeader(){
        let head:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: (kScreenWidth-20)/5 + 80))
        self.listTab.tableHeaderView = head
        
        let lab:UILabel = UILabel.init(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
        lab.font = UIFont.systemFont(ofSize: 14)
        head.addSubview(lab)
        lab.text = "推荐关注"
        
        let perwd:CGFloat = (kScreenWidth-20)/5
        for i in 0...4{
            let btn:UIButton = UIButton.init(type: .custom)
            btn.frame = CGRect(x: 15 + CGFloat(i)*perwd, y: 40, width: perwd-10, height: perwd+30)
            btn.kf.setImage(with: URL(string: "http://wimg.spriteapp.cn/profile/20180902101159388986.png"), for: .normal)
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
//            btn.titleEdgeInsets = UIEdgeInsets(top: perwd+10, left: -perwd, bottom: -20, right: 0)
            let lab = UILabel.init(frame: CGRect(x: 0, y: perwd, width: perwd, height: 20))
            lab.text = "李梓淇"
            lab.font = UIFont.systemFont(ofSize: 15)
            lab.textColor = .gray
            lab.textAlignment = .center
            btn.addSubview(lab)
            
            head.addSubview(btn)
        }
        
    }
    

 
}
extension AttentionViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContentTableViewCell
        
        cell.model = self.dataArr[indexPath.row]
        cell.imgShowData = {model in
            self.showBigPicture(model1: model, cell: cell)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model:EseenceModel = self.dataArr[indexPath.row]
        return model.cellHeight
    }
    
    func showBigPicture(model1:EseenceModel,cell:ContentTableViewCell){
        if model1.type != "video" {
            let show =  ShowImageView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            show.outFrame = cell.frame
            self.view.addSubview(show)
            show.show(model: model1)
        }
        
        
    }
}
