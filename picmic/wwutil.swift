//
//  wwutil.swift
//  picmic
//
//  Created by mac on 2018. 9. 3..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
class wwUtil:NSObject,AVCapturePhotoCaptureDelegate{
    var view:UIViewController!
    var delegate:AVCapturePhotoCaptureDelegate!
    var captureSession=AVCaptureSession()
    var backCam:AVCaptureDevice?
    var frontCam:AVCaptureDevice?
    var currentCam:AVCaptureDevice?
    
    var PhotoOutput:AVCapturePhotoOutput?
    
    var cameraPreview:AVCaptureVideoPreviewLayer?
    override init(){
        
    }
    
    init(view:UIViewController) {
        self.view=view
        
        
    }
    init(view:UIViewController,preView:UIView,delegate:AVCapturePhotoCaptureDelegate) {
        super.init()
        
        self.view=view
        self.delegate=delegate
        
        self.setCaptureSession()
        self.setDevice()
        self.setInOut()
        self.setPreview(on:preView)
           self.startCamera()
 
        
        
    }
    
    func alert(title:String,text:String){
        let alert=UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default , handler: nil))
        view.present(alert, animated: true)
    }
    
    func alert(title:String,text:String,sHandle:(()->Void)?,fHandle:(()->Void)?){
        let alert=UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default ){
            (UIAlertAction)in sHandle?()
        })
        alert.addAction(UIAlertAction(title: "취소", style: .default ){
            (UIAlertAction)in fHandle?()
        })
        view.present(alert, animated: true)
    }
    

    
    
    func setCaptureSession(){
        captureSession.sessionPreset=AVCaptureSession.Preset.hd1920x1080
    }
    func setDevice(){
       let deviceDiscverSession=AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        let devices=deviceDiscverSession.devices
        
        for device in devices{
            if device.position==AVCaptureDevice.Position.back{
                backCam=device
            }else if device.position==AVCaptureDevice.Position.front{
                frontCam=device
            }
        }
        currentCam=backCam
 
        currentCam=AVCaptureDevice.default(for: AVMediaType.video)
    }
    
    
    
    func setInOut(){
        do{
            
            let captureDeviceInput=try AVCaptureDeviceInput(device: currentCam!)
           
            captureSession.addInput(captureDeviceInput)
            
           captureSession.sessionPreset = .hd1920x1080
        PhotoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])], completionHandler: nil)
            PhotoOutput=AVCapturePhotoOutput()
            
            captureSession.addOutput(PhotoOutput!)
            
        }catch{
            print(error)
        }
        
    }
    func setPreview(on view:UIView){
       
        cameraPreview=AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreview?.videoGravity=AVLayerVideoGravity.resizeAspectFill
        cameraPreview?.connection?.videoOrientation=AVCaptureVideoOrientation.portrait
 
        DispatchQueue.global().async {
            self.captureSession.startRunning()
       
        }
       
    }
    func loadView(on view:UIView){
        DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                view.layer.addSublayer(self.cameraPreview!)
                self.cameraPreview?.frame=view.frame
            }
        }
    }
    func startCamera(){
        
        
    }
    
    func capture(){
        
        let photoSetting=AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])
        photoSetting.isAutoStillImageStabilizationEnabled=true
        photoSetting.flashMode = .off
        
   
        
        PhotoOutput!.capturePhoto(with: photoSetting, delegate: delegate)
        
        
    }
    
    
    func runCamera(on view:UIView){
        
        
     
        
        print("==============START CAMERA==========")
    }
    
    
    func camPerAlert(){
        
    }
    
    
    func setupImage(imgUid:String,imgPath:String,imgView:UIImageView){
        let url=URL(string: "http://180.224.166.87:3000/pick/getimage?uid="+imgUid+"&path="+imgPath)
        var req=URLRequest(url: url!)
        req.httpMethod="GET"
        let session=URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: req){
            (data,res,error) in
            DispatchQueue.main.async {
                imgView.image=UIImage(data: data!)
                
            }
            }.resume()
    }
    
    func addBottomBorder(bview:UIView){
        let view = UIView(frame: CGRect(x: 0, y: bview.frame.height, width: bview.frame.width, height: 1))
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0
        bview.addSubview(view)
        
    }
    
    func addHalfBottomBorder(bview:UIView){
        let view = UIView(frame: CGRect(x: 0, y: bview.frame.height-10, width: 1000, height: 10))
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0
        bview.addSubview(view)
        
    }
    
    func addTopBorder(bview:UIView){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: bview.frame.width, height: 1))
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0
        bview.addSubview(view)
        
    }
    
    
}
