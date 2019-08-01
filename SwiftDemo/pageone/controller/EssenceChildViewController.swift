//
//  EssenceChildViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/22.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit
import ESPullToRefresh
import AVKit
class EssenceChildViewController: BaseViewController {
    
    var dataArr:Array<EseenceModel>! = []
    var page:Int = 1
    var palyCell:ContentTableViewCell =  ContentTableViewCell()
    var palyerItem:AVPlayerItem!
    var player:AVPlayer!
    var playerLayer:AVPlayerLayer!
    var player1 : VGPlayer = VGPlayer()
    

  var typeCC: ContentType = .all
    lazy var tableV:UITableView = {
        let tab = UITableView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height:kScreenHeight-kTopHeight-kTabBarHeight), style: .plain)
        tab.delegate = self
        tab.es.addPullToRefresh {
            self.page=1
            self.requestData()
        }
        tab.es.startPullToRefresh()

        tab.register(ContentTableViewCell.self, forCellReuseIdentifier: "cell")
        tab.dataSource = self
        return tab;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableV)

     
        
        self.view.backgroundColor = UIColor.gray

    }
    func requestData()  {
        EssenceViewModel.loadContent(a: "1", type: self.typeCC, page: 1) { (sucess,mtime,array) in
            if self.page==1{
                self.dataArr = array
            }else{
                 self.dataArr.insert(contentsOf: array, at: array.count);
            }
           self.tableV.es.stopPullToRefresh()
            self.tableV.reloadData()
        }
    }

}
extension EssenceChildViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContentTableViewCell
        let model:EseenceModel = self.dataArr[indexPath.row]
        cell.model = model
        cell.selectionStyle = .none
        cell.imgShowData = {(cuurentModel:EseenceModel) in
        
            self.showBigPicture(model1: model, cell: cell)
        }
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model:EseenceModel = self.dataArr[indexPath.row]
        return model.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail:EssenceDetailVC = EssenceDetailVC()
        self.navigationController?.pushViewController(detail, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cells = self.tableV.visibleCells
        if cells.contains(self.palyCell){
            if let play = self.player{
                if let layer = playerLayer{
            
                    layer.removeFromSuperlayer()
                }
                
                
                play.pause()
            }
        }
       
       
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let cells = self.tableV.visibleCells
        if cells.contains(self.palyCell){
            if let play = self.player{
                if let layer = playerLayer{
                    
                    layer.removeFromSuperlayer()
                }
                
                
                play.pause()
            }
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        getPlayCell()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        getPlayCell()

    }
    
    func getPlayCell() {
        var firstCell :ContentTableViewCell
        let cells = self.tableV.visibleCells
        for cell in cells {
            if cell.isKind(of: ContentTableViewCell.self){
                firstCell = cell as! ContentTableViewCell
                if firstCell.model.type=="video"{
                    self .initPlay(cell: firstCell, model: firstCell.model)
                    break
                }
               
            }
        }
        
    }
    func initPlay(cell:ContentTableViewCell,model:EseenceModel){
        self.palyCell = cell
      let  model: EseenceModel = self.palyCell.model

        if self.player?.rate != 0.0{
            self.player?.pause()
            self.palyerItem = nil
            self.player = nil
            playerLayer?.removeFromSuperlayer()
        }
        
      
        
        self.palyerItem = AVPlayerItem(url: NSURL(string: model.video?.video[0] ?? "")! as URL)
        //创建ACplayer：负责视频播放
        self.player = AVPlayer.init(playerItem: self.palyerItem)
        self.player.rate = 1.0//播放速度 播放前设置
        //创建显示视频的图层
        playerLayer = AVPlayerLayer.init(player: self.player)
        playerLayer.videoGravity = .resizeAspect
        playerLayer.frame = model.videoFrame
        self.palyCell.contentView.layer.addSublayer(playerLayer)
        //播放
        self.player.play()
        
//        self.player1.replaceVideo(NSURL(string: model.video?.video[0] ?? "")! as URL)
//        self.palyCell.contentView.addSubview(self.player1.displayView)
//
//        self.player1.play()
//        self.player1.backgroundMode = .proceed
//        self.player1.delegate = self
//        self.player1.displayView.delegate = self
//        self.player1.displayView.titleLabel.text = "China NO.1"
//        self.player1.displayView.frame = model.videoFrame
    }
    
    
    
}
extension EssenceChildViewController{
    //查看大图
    func showBigPicture(model1:EseenceModel,cell:ContentTableViewCell){
        if model1.type != "video" {
            let show =  ShowImageView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            show.outFrame = cell.frame
            self.view.addSubview(show)
            show.show(model: model1)
        }
    
        
    }
    
    
}

extension EssenceChildViewController: VGPlayerDelegate {
    func vgPlayer(_ player: VGPlayer, playerFailed error: VGPlayerError) {
        print(error)
    }
    func vgPlayer(_ player: VGPlayer, stateDidChange state: VGPlayerState) {
        print("player State ",state)
    }
    func vgPlayer(_ player: VGPlayer, bufferStateDidChange state: VGPlayerBufferstate) {
        print("buffer State", state)
    }
    
}

extension EssenceChildViewController: VGPlayerViewDelegate {
    
    func vgPlayerView(_ playerView: VGPlayerView, willFullscreen fullscreen: Bool) {
        
    }
    func vgPlayerView(didTappedClose playerView: VGPlayerView) {
        if playerView.isFullScreen {
            playerView.exitFullscreen()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    func vgPlayerView(didDisplayControl playerView: VGPlayerView) {
        UIApplication.shared.setStatusBarHidden(!playerView.isDisplayControl, with: .fade)
    }
}

