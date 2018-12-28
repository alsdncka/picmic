//
//  FeeView.swift
//  picmic
//
//  Created by mac on 2018. 9. 5..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
class FeedViewController:UIViewController,CLLocationManagerDelegate,UIScrollViewDelegate{
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    var locationManager:CLLocationManager!
    var x:String?
    var y:String?
    var l_si:String?
    var l_do:String?
    var l_dong:String?
    var gpscnt:Int=0;
    
    @IBOutlet weak var srcView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       startGPS()
    }
    
    func startGPS(){
        locationManager=CLLocationManager()
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func stopGPS(){
            locationManager.stopUpdatingLocation()
        
    }
    
    func loadFeed(){
        var x:CGFloat?
        var y:CGFloat?
        var w:CGFloat?
        var h:CGFloat?
        
        let stackFrame=self.srcView.frame
        
        x=stackFrame.minX
        y=stackFrame.minY
        w=stackFrame.size.width
        h=stackFrame.size.height
        
        
        var param:Parameters=["x":x,"y":y,"do_text":l_do,"si_text":l_si,"dong_text":l_dong]
        
        Alamofire.request(wwurl().getLoadFeeds(), method: .post, parameters: param, encoding:JSONEncoding.default).responseJSON{
            
            res in
            do{
                let json=try JSON(data: res.data!)
                for (key,val) in json{
                    
                    let feedCont=Bundle.main.loadNibNamed("feedViewController", owner: self, options: nil)?.first as! feedController
                    
                    self.srcView.delegate=self
                    
                    feedCont.frame=CGRect(x: x!, y: h!*CGFloat(Int(key)!), width: w!, height: h!)
                    feedCont.contData=val
                   
                
                    self.srcView.addSubview(feedCont)
                    
                }
            
               self.srcView.contentSize=CGSize(width: w!, height: h!*CGFloat(json.count))
               
         
                
                
                
                
            }catch{
                print("error")
                
            }
        }
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coor=manager.location?.coordinate{
            x=String(coor.latitude)
            y=String(coor.longitude)
            let geo=CLGeocoder()
            let local=Locale(identifier: "Ko-kr")
            geo.reverseGeocodeLocation(CLLocation(latitude: coor.latitude, longitude: coor.longitude), completionHandler: {
                (place,error) in
                self.l_do=place?.last?.administrativeArea
                self.l_si=place?.last?.locality
                
                self.l_dong=place?.last?.subLocality
                if self.gpscnt==0{
                self.loadFeed()
                self.stopGPS()
                }
                
                self.gpscnt+=1
            })
          
        }
   
        
    }
   
    
    @objc func dialog(sender:UITapGestureRecognizer){
    
        var backgroundView=UIView()
        var dialogView=UIView()
        backgroundView.frame=CGRect(x: 0, y: 0, width: 100, height: 100)
        
        backgroundView.backgroundColor=UIColor.black
        backgroundView.alpha=0.6
    
        srcView.addSubview(backgroundView)
    
    
        dialogView.center=CGPoint(x: srcView.center.x, y: srcView.center.y)
        dialogView.frame.size=CGSize(width: 100, height: 100)
    dialogView.backgroundColor=UIColor.white
    srcView.addSubview(dialogView)
    
    
    }
 
}


