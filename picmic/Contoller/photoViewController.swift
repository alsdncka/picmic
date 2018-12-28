//
//  photoViewController.swift
//  picmic
//
//  Created by mac on 2018. 9. 3..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreLocation
class photoViewController:UIViewController,AVCapturePhotoCaptureDelegate,CLLocationManagerDelegate,UIApplicationDelegate{
    
    
    var picker:wwUtil?
    var locationManager:CLLocationManager!
    var x:String?
    var y:String?
    var l_do:String?
    var l_si:String?
    var l_dong:String?
    
    @IBOutlet weak var cameraView: UIImageView!
    
    @IBOutlet var stackView: UIStackView!
    
 
    
    @IBAction func pickBt(_ sender: Any) {
        if(x != nil||y != nil){
            picker?.capture()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PHOTO")
        loadContent()
        picker=wwUtil(view:self,preView:cameraView,delegate:self)
    }

  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
 

    override func viewDidLayoutSubviews() {
     
      picker?.loadView(on: cameraView)
     

    }

    
    func loadContent(){
        locationManager=CLLocationManager()
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        camPer()
        
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
       locationManager.startUpdatingLocation()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
       // picker?.runCamera(on: cameraView)
        
    }
    

    func camPer(){
        
        let statusC=AVCaptureDevice.authorizationStatus(for: .video)
      
        if statusC == .restricted||statusC == .denied{
            picker?.alert(title: "GPS", text: "사진을 찍기위해 카메라 권한이 필요합니다.", sHandle: reqPermission, fHandle: nil)
        }else{
            
        }
  
    }
    
    func reqPermission(){
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    func loPer(){
            let statusL=CLLocationManager.authorizationStatus()
        if statusL==CLAuthorizationStatus.denied||statusL==CLAuthorizationStatus.restricted{
            
            picker?.alert(title: "GPS", text: "사진의 위치정보가 필요합니다.", sHandle: reqPermission, fHandle: nil)
            
        }else{
            checkPer()
        }
    }
    
    func checkPer(){
        
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        
        if var imageData=photo.fileDataRepresentation(){
            var captureImage=UIImage(data: imageData)
        
            
            captureImage = cropImage(captureImage!)
            
         
            imageData=captureImage!.jpegData(compressionQuality: 1)!
            
            
            
           wwhttp().uploadImage(url: wwurl().getPickImage(), imageData: imageData, X: x!, Y: y!,l_do: l_do!,l_si: l_si!,l_dong: l_dong!,ctrl:self)
             locationManager.stopUpdatingLocation()
            
        }
    }
    
    func cropImage(_ image:UIImage)->UIImage{
        let orientation : UIDeviceOrientation = UIDevice.current.orientation
        var imageW = image.size.width
        var imageH = image.size.height
        print(orientation)
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            imageW = image.size.height
            imageH = image.size.width
            
        default:break
        }
        
        let rcy = imageH * 0.5
        let rect = CGRect(x: rcy - imageW * 0.5, y: 0, width: imageW, height: imageW)
        let imageRef = image.cgImage?.cropping(to: rect)
        
        return UIImage(cgImage: imageRef!, scale: 1.0, orientation: image.imageOrientation)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coor=manager.location?.coordinate{
            self.x=String(coor.latitude)
            self.y=String(coor.longitude)
            
            let geo=CLGeocoder()
            let local=Locale(identifier: "Ko-kr")
            geo.reverseGeocodeLocation(CLLocation(latitude: coor.latitude, longitude: coor.longitude), completionHandler: {
                (place,error) in
               self.l_do=place?.last?.administrativeArea
                self.l_si=place?.last?.locality
                self.l_dong=place?.last?.subLocality
                
      
                
            })
        }
        
        
        
    }
   
    
    
   
    
}
