//
//  CustcarmeViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/8/2.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit
import Photos
import AVKit
@available(iOS 10.0, *)
@available(iOS 11.0, *)
class CustcarmeViewController: UIViewController,AVCapturePhotoCaptureDelegate,AVCaptureFileOutputRecordingDelegate {

    var device:AVCaptureDevice!//摄像头
    var input:AVCaptureDeviceInput!
    var inputAudio:AVCaptureDeviceInput!

    var photoOutput:AVCapturePhotoOutput!//照片输出流
    var movieoutput:AVCaptureMovieFileOutput! //录像输出流
    var output:AVCaptureMetadataOutput!
    var session:AVCaptureSession!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var setings:AVCapturePhotoSettings!
    var stilImage:AVCaptureStillImageOutput!

    var photoBtn:UIButton?
    var imageView:UIImageView?
    var isgetMark :Bool?
    var isFlash:Bool = false
    
    var flashBtn :UIButton?
    var videoConnection :AVCaptureConnection?
    var audioConnection :AVCaptureConnection?

    var dismissBtn:UIButton!
    //录像
    var videoSet = [AVAsset]()
    var assetURLS = [String]()
    
    var appendix:Int32 = 1
    let totalSeconds:Float64 = 15
    //每秒帧数
    var framesPerSecond:Int32 = 30
    //剩余时间
    var remainingTime : TimeInterval = 15.0
    
    //表示是否停止录像
    var stopRecording: Bool = false
    //剩余时间计时器
    var timer: Timer?
    //进度条计时器
    var progressBarTimer: Timer?
    //进度条计时器时间间隔
    var incInterval: TimeInterval = 0.05
    //进度条
    var progressBar: UIView = UIView()
    //当前进度条终点位置
    var oldX: CGFloat = 0
    //录制、保存按钮
    var recordButton, saveButton : UIButton!
    //视频片段合并后的url
    var outputURL: NSURL?
  
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        creatCustomerView()
        customeUI()

       
    }
    
    func creatCustomerView(){
    
        let device11:AVCaptureDevice! = AVCaptureDevice.default(for: .audio)
        let device:AVCaptureDevice! = AVCaptureDevice.default(for: .video)
        self.device = device
        setings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])
        self.input = try?AVCaptureDeviceInput(device: device)
        self.inputAudio = try?AVCaptureDeviceInput(device: device11)
        self.photoOutput = AVCapturePhotoOutput.init()
        self.movieoutput = AVCaptureMovieFileOutput.init()
        self.output = AVCaptureMetadataOutput.init()
        
        self.stilImage = AVCaptureStillImageOutput.init()
        self.stilImage.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
        self.session = AVCaptureSession.init()
        
        if (self.session.canSetSessionPreset(AVCaptureSession.Preset(rawValue: "AVCaptureSessionPreset1280x720"))){
            self.session.sessionPreset = AVCaptureSession.Preset(rawValue: "AVCaptureSessionPreset1280x720")
        }
        
        self.session.sessionPreset = .high
        if(self.session.canAddInput(self.input)){
            self.session.addInput(self.input)
        }
        
        if(self.session.canAddOutput(self.photoOutput)){
            self.session.addOutput(self.photoOutput)
        }
        
        //添加一个音频输入设备
//        let audioCaptureDevice=AVCaptureDevice.devices(for: AVMediaType.audio).first
//        let audioInput=try? AVCaptureDeviceInput.init(device: audioCaptureDevice!)
        if(self.session.canAddInput(inputAudio!)){
            self.session.canAddInput(inputAudio!)
            
        }
        
        //添加视频输出流到会话中
        if(self.session.canAddOutput(self.movieoutput)){
            self.session.addOutput(self.movieoutput)
           
        }
        if(self.session.canAddOutput(self.stilImage)){
            self.session.addOutput(self.stilImage)
        }
      
        self.previewLayer = AVCaptureVideoPreviewLayer.init(session: self.session)
        self.previewLayer.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.previewLayer.videoGravity = AVLayerVideoGravity(rawValue: "AVLayerVideoGravityResizeAspectFill")
       self.view.layer.addSublayer(self.previewLayer)
        self.session.startRunning()
      

        progressBar.frame = CGRect(x: 0, y: 40, width: self.view.bounds.width,
                                   height: self.view.bounds.height * 0.01)
        progressBar.backgroundColor = UIColor(red: 4, green: 3, blue: 3, alpha: 0.5)
        self.view.addSubview(progressBar)
        
  //setupButton()
    }
    
    func customeUI(){
        
        //切换摄像头
        let changeBtn = UIButton.init(type: .custom)
        changeBtn.frame = CGRect(x: Int(kScreenWidth-50), y: Int(kTopHeight), width: 40, height: 30)
        changeBtn.setImage(UIImage(named: "change"), for: .normal)
        changeBtn.addTarget(self, action: #selector(changeClick), for: .touchUpInside)
        view.addSubview(changeBtn)
        //拍照按钮
        photoBtn = UIButton.init(type: .custom)
        photoBtn?.frame = CGRect(x: kScreenWidth/2 - 30, y: kScreenHeight-100, width: 60, height: 50)
        photoBtn?.setBackgroundImage(UIImage.init(named: "takePhoto"), for: .normal)
        photoBtn?.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)

        view.addSubview(photoBtn!)
        
        //闪光灯按钮
        flashBtn = UIButton.init()
        flashBtn?.frame = CGRect.init(x: kScreenWidth-50, y:kTopHeight+60, width: 40, height: 40)
        flashBtn?.addTarget(self, action: #selector(flashAction), for: .touchUpInside)
        flashBtn?.setImage(UIImage.init(named: "flash"), for: UIControl.State.normal)
        view.addSubview(flashBtn!)
        
        //取消
        let cancelBtn = UIButton.init()
        cancelBtn.frame = CGRect.init(x: 10, y: kScreenHeight - 100, width: 60, height: 50)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelActin), for: .touchUpInside)
        view.addSubview(cancelBtn)
        
        dismissBtn = UIButton.init(type: .custom)
        dismissBtn?.frame = CGRect(x: 20, y: 60, width: 40, height: 40)
        dismissBtn?.setBackgroundImage(UIImage.init(named: "取消"), for: .normal)
        dismissBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        view.addSubview(dismissBtn!)

    }
    
    //创建按钮
    func setupButton(){
        //创建录制按钮
        
        self.recordButton = UIButton(frame:  CGRect.init(x: 0, y: 0, width: 120, height: 50))
        self.recordButton.backgroundColor = UIColor.red;
        self.recordButton.layer.masksToBounds = true
        self.recordButton.setTitle("按住录像", for: UIControl.State.normal)
        self.recordButton.layer.cornerRadius = 20.0
        self.recordButton.layer.position = CGPoint(x: Int(self.view.bounds.width/2),
                                                   y:Int(self.view.bounds.height)-Int(kTabBarHeight)-150)
        self.recordButton.addTarget(self, action: #selector(onTouchDownRecordButton),
                                    for: .touchDown)
        self.recordButton.addTarget(self, action: #selector(onTouchUpRecordButton),
                                    for: .touchUpInside)
        
        //创建保存按钮
        self.saveButton = UIButton(frame: CGRect.init(x: 0, y: 0, width: 70, height: 50))
        
        self.saveButton.backgroundColor = UIColor.gray;
        self.saveButton.layer.masksToBounds = true
        self.saveButton.setTitle("保存", for: UIControl.State.normal)
        self.saveButton.layer.cornerRadius = 20.0
        
        self.saveButton.layer.position = CGPoint(x: Int(self.view.bounds.width) - 60,
                                                 y:Int(self.view.bounds.height)-Int(kTabBarHeight)-150)
        self.saveButton.addTarget(self, action: #selector(onClickStopButton),
                                  for: .touchUpInside)
        
        
        //回看按钮
        let backlookBtn:UIButton=UIButton.init(frame: CGRect.init(x: 100, y: 200, width: 100, height: 50))
        backlookBtn.setTitle("回看按钮", for: UIControl.State.normal)
        backlookBtn.addTarget(self, action:#selector(reviewRecord) , for: .touchUpInside)
        view.addSubview(backlookBtn)
        //添加按钮到视图上
        self.view.addSubview(self.recordButton);
        self.view.addSubview(self.saveButton);
    }
    
    //按下录制按钮，开始录制片段
    @objc func  onTouchDownRecordButton(sender: UIButton){
        
        if(!stopRecording) {
            guard movieoutput.isRecording == false else {
                print("movieOutput.isRecording\n")
                movieoutput.stopRecording()
                return;
            }
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                            .userDomainMask, true)
            let documentsDirectory = paths[0] as String
            let outputFilePath = "\(documentsDirectory)/output-\(appendix).mov"
            appendix += 1
            let outputURL = NSURL(fileURLWithPath: outputFilePath)
            let fileManager = FileManager.default
            if(fileManager.fileExists(atPath: outputFilePath)) {
                
                do {
                    try fileManager.removeItem(atPath: outputFilePath)
                } catch _ {
                }
            }
            print("开始录制：\(outputFilePath) ")
//            audioConnection = movieoutput.connection(with: .audio)
//            if audioConnection == nil {
//                print("take photo failed!")
//                return
//            }
//            if self.session.isRunning{
//                self.session.startRunning()
//            }
//            connection?.videoOrientation = self.previewLayer.connection!.videoOrientation
////            if (connection?.isVideoOrientationSupported)!{
////                connection?.videoOrientation = currentVideoOrientation()
////            }
////            // 设置连接的视频自动稳定，手机会选择合适的拍摄格式和帧率
//            if (connection?.isVideoStabilizationSupported)!{
//                connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
//            }
//            movieoutput.startRecording(to: outputURL as URL, recordingDelegate: self as! AVCaptureFileOutputRecordingDelegate)
            movieoutput.startRecording(to: outputURL as URL, recordingDelegate: self as AVCaptureFileOutputRecordingDelegate)
        }
    }
    
    //录像结束
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?){
        
        print("走了这个d放发")
        let asset:AVURLAsset = AVURLAsset(url: outputFileURL)
        var duration:TimeInterval = 0.0
        duration = CMTimeGetSeconds(asset.duration)
        videoSet.append(asset)
        assetURLS.append(outputFileURL.path)
        remainingTime = remainingTime - duration
        if remainingTime<=0{
            
        }
        
    }
    //录像开始的代理方法
    func captureOutput(captureOutput: AVCaptureFileOutput!,
                       didStartRecordingToOutputFileAtURL fileURL: NSURL!,
                       fromConnections connections: [AnyObject]!) {
        print("走了这个d99999放发")

        startProgressBarTimer()
        startTimer()
    }
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!)
    {
        
    }

    
   
  
    //剩余时间计时器
    func startTimer() {
        timer = Timer(timeInterval: remainingTime, target: self,
                      selector: #selector(timeout), userInfo: nil,
                      repeats:true)
        RunLoop.current.add(timer!, forMode: RunLoop.Mode.default)
    }
    //进度条计时器
    func startProgressBarTimer() {
        progressBarTimer = Timer(timeInterval: incInterval, target: self,
                                 selector: #selector(progress),
                                 userInfo: nil, repeats: true)
        RunLoop.current.add(progressBarTimer!,
                            forMode: RunLoop.Mode.default)
    }
    @objc func timeout(){
     stopRecording = true
        movieoutput.stopRecording()
        timer?.invalidate()
        progressBarTimer?.invalidate()
    }
    @objc func progress(){
        let progressProportion: CGFloat = CGFloat(incInterval / totalSeconds)
        let progressInc: UIView = UIView()
        progressInc.backgroundColor = UIColor(red: 55/255, green: 186/255, blue: 89/255,
                                              alpha: 1)
        let newWidth = progressBar.frame.width * progressProportion
        progressInc.frame = CGRect(x: oldX , y: 0, width: newWidth,
                                   height: progressBar.frame.height)
        oldX = oldX + newWidth
        progressBar.addSubview(progressInc)
        
    }
  
    
    //松开录制按钮，停止录制片段
    @objc func  onTouchUpRecordButton(sender: UIButton){
        if(!stopRecording) {
            timer?.invalidate()
            progressBarTimer?.invalidate()
            movieoutput.stopRecording()
        }
    }
    
    @objc func onClickStopButton(){
                mergeVideos()
    }
    @objc func reviewRecord(){
        let player = AVPlayer(url: outputURL! as URL)
        let playerViewController:AVPlayerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
            }
        
    }
    
    
    
    
   @objc func changeClick()  {
    guard var position = input?.device.position else { return }
    
    //获取当前应该显示的镜头
    position = position == .front ? .back : .front
    //2.重新创建输入设备对象
    //创建新的device
    let devices = AVCaptureDevice.devices(for: AVMediaType.video) as [AVCaptureDevice]
    for devic in devices{
        if devic.position==position{
            device = devic
        }
    }
    
    //input
    guard let videoInput = try? AVCaptureDeviceInput(device: device!) else { return }
    
    //3. 改变会话的配置前一定要先开启配置，配置完成后提交配置改变
    session.beginConfiguration()
    //移除原有设备输入对象
    session.removeInput(input)
    //添加新的输入对象
    //添加输入到会话中
    if(self.session.canAddInput(videoInput)){
        
        self.session.addInput(videoInput)
        input = videoInput
    }
    //提交会话配置
    session.commitConfiguration()
   
 
}
    @objc func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func takePhoto()  {
        
        //切换
        setings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])

        videoConnection = photoOutput.connection(with: AVMediaType.video)
        if videoConnection == nil {
            print("take photo failed!")
            return
        }
           photoOutput.capturePhoto(with: setings!, delegate: self)
        
    }
    //手电筒
    @objc func flashAction()  {
        isFlash = !isFlash
        
        try? device.lockForConfiguration()
        if(isFlash){
            if device.hasTorch{
                device.torchMode = .on
                
            }
            
        }else{
            if device.hasTorch{
                device.torchMode = .off
                
            }
        }
               device.unlockForConfiguration()
    }
    
    @objc func cancelActin()  {
        self.imageView?.removeFromSuperview()
        if(!session.isRunning){
            session.startRunning()
        }
    }
  //photo
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        session.stopRunning()//停止
        let imagedata  =  AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
        guard let image=UIImage.init(data: imagedata!) else { return  }
        let imageV=UIImageView.init(frame: CGRect.init(x: kScreenWidth-70, y:kScreenHeight-100, width: 50, height: 50))
            imageV.image=image
            view.addSubview(imageV)
        imageV.isUserInteractionEnabled = true
        imageV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lookLocalPicture)))
       UIImageWriteToSavedPhotosAlbum(image, self, #selector(save(image:didFinishSavingWithError:contextInfo:)), nil)
    }
   

    
   
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingLivePhotoToMovieFileAt outputFileURL: URL, duration: CMTime, photoDisplayTime: CMTime, resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        print(outputFileURL)
        
    }
   @objc func save(image:UIImage, didFinishSavingWithError:NSError?,contextInfo:AnyObject) {
        
        if didFinishSavingWithError != nil {
            SVProgressHUD.showError(withStatus: "保存失败")
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        } else {
            SVProgressHUD.showSuccess(withStatus: "保存成功")
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        }
    session.startRunning()

    }
    
    @objc func lookLocalPicture(){
        
    }
   
    //合并视频片段
    func mergeVideos() {
        let duration = totalSeconds
        
        let composition = AVMutableComposition()
        //合并视频、音频轨道
        let firstTrack = composition.addMutableTrack(
            withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)//获取工程文件中的视频轨道
        _ = composition.addMutableTrack(
            withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)//获取工程文件中的音频轨道
        
        var insertTime: CMTime = CMTime.zero
        for asset in videoSet {
            print("合并视频片段001：\(asset)")
            let videoArr  =     asset.tracks(withMediaType: AVMediaType.video)//从素材中获取视频轨道
            do {
                try firstTrack!.insertTimeRange(
                    CMTimeRangeMake(start: CMTime.zero, duration: asset.duration),
                    of: videoArr[0] ,
                    at: insertTime)
            } catch _ {
            }
            
            let audioArr = asset.tracks(withMediaType: AVMediaType.audio)//从素材中获取音频轨道
            print("\(audioArr.count)-----\(videoArr.count)")
            do {
                //                try audioTrack!.insertTimeRange(
                //                    CMTimeRangeMake(start: CMTime.zero, duration: asset.duration),
                //                    of: audioArr[0],
                //                    at: insertTime)
            } catch _ {
            }
            
            insertTime = CMTimeAdd(insertTime, asset.duration)
        }
        //旋转视频图像，防止90度颠倒
        firstTrack!.preferredTransform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        
        //定义最终生成的视频尺寸（矩形的）
        print("视频原始尺寸：", firstTrack!.naturalSize)
        let renderSize = CGSize.init(width: firstTrack!.naturalSize.height, height: firstTrack!.naturalSize.height)
        print("最终渲染尺寸：", renderSize)
        
        //通过AVMutableVideoComposition实现视频的裁剪(矩形，截取正中心区域视频)
        let videoComposition = AVMutableVideoComposition()
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: framesPerSecond)
        videoComposition.renderSize = renderSize
        
        //视频组合指令
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(
            start: CMTime.zero,duration: CMTimeMakeWithSeconds(Float64(duration), preferredTimescale: framesPerSecond))
        
        
        let transformer: AVMutableVideoCompositionLayerInstruction =
            AVMutableVideoCompositionLayerInstruction(assetTrack: firstTrack!)
        //        let t1 = CGAffineTransform(translationX: firstTrack!.naturalSize.height,
        //                                   y: -(firstTrack!.naturalSize.width-firstTrack!.naturalSize.height)/2)
        //        let t2 = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        //        let finalTransform: CGAffineTransform = t2
        //        transformer.setTransform(finalTransform, at: CMTime.zero)
        
        instruction.layerInstructions = [transformer]//视频涂层指令集合
        videoComposition.instructions = [instruction]
        
        //获取合并后的视频路径
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                .userDomainMask,true)[0]
        let destinationPath = documentsPath + "/mergeVideo-\(arc4random()%1000).mov"
        print("合并后的视频002：\(destinationPath)")
        let videoPath: NSURL = NSURL(fileURLWithPath: destinationPath as String)
        let exporter = AVAssetExportSession(asset: composition,
                                            presetName:AVAssetExportPresetHighestQuality)!
        exporter.outputURL = videoPath as URL
        exporter.outputFileType = AVFileType.mov
        exporter.videoComposition = videoComposition //设置videoComposition
        exporter.shouldOptimizeForNetworkUse = true
        exporter.timeRange = CMTimeRangeMake(
            start: CMTime.zero,duration: CMTimeMakeWithSeconds(Float64(duration), preferredTimescale: framesPerSecond))
        exporter.exportAsynchronously(completionHandler: {
            print("导出状态\(exporter.status)")
            //将合并后的视频保存到相册
            self.exportDidFinish(session: exporter)
        })
    }
    
    //将合并后的视频保存到相册
    func exportDidFinish(session: AVAssetExportSession) {
        print("视频合并成功！")
        weak var weakSelf=self
        outputURL = session.outputURL! as NSURL
        //将录制好的录像保存到照片库中
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: weakSelf!.outputURL! as URL)//保存录像到系统相册
        }, completionHandler:{(isSuccess: Bool, error: Error?) in
            DispatchQueue.main.async {
                
                //重置参数，吧碎片视频全部删除
                self.reset()
                
                //弹出提示框
                let alertController = UIAlertController(title: "视频保存成功",
                                                        message: "是否需要回看录像？", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                    action in
                    //录像回看
                    weakSelf?.reviewRecord()
                })
                let cancelAction = UIAlertAction(title: "取消", style: .cancel,
                                                 handler: nil)
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true,
                             completion: nil)
            }
        }
        )
    }
    //视频保存成功，重置各个参数，准备新视频录制
    func reset() {
        //删除视频片段
        for assetURL in assetURLS {
            if(FileManager.default.fileExists(atPath: assetURL)) {
                do {
                    try FileManager.default.removeItem(atPath: assetURL)
                } catch _ {
                }
                print("删除视频片段: \(assetURL)")
            }
        }
        
        //进度条还原
        let subviews = progressBar.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
        
        //各个参数还原
        videoSet.removeAll(keepingCapacity: false)
        assetURLS.removeAll(keepingCapacity: false)
        appendix = 1
        oldX = 0
        stopRecording = false
        remainingTime = totalSeconds
    }
   

}
//@available(iOS 10.0, *)
//@available(iOS 11.0, *)
//extension CustcarmeViewController:AVCaptureFileOutputRecordingDelegate{
//    //录像开始的代理方法
//    func captureOutput(captureOutput: AVCaptureFileOutput!,
//                       didStartRecordingToOutputFileAtURL fileURL: NSURL!,
//                       fromConnections connections: [AnyObject]!) {
//        startProgressBarTimer()
//        startTimer()
//    }
//
//
//}
