//
//  uploadDetailController.swift
//  picmic
//
//  Created by mac on 2018. 9. 12..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import CoreLocation

class uploadDetailViewController:UIViewController,UITextFieldDelegate,UIScrollViewDelegate{
    var uploadImage:[UIImage]=[]
    var uploadItem:[JSON]=[]
    var imgViews:[imageController]=[]
    var avg_x:Double=0
    var avg_y:Double=0
    var l_do:String?
    var l_si:String?
    var l_dong:String?
    
    @IBOutlet weak var pageC: UIPageControl!
    
    @IBOutlet weak var imgScrView: UIScrollView!
    

    @IBOutlet weak var titleField: UITextField!{didSet{titleField.delegate=self}}
    

    @IBOutlet weak var textField: UITextView!{
        didSet{
            
        }
    }
    
    @IBOutlet weak var st: UIStackView!
    
    @IBOutlet var mainView: UIView!
    
    @IBAction func uploadBt(_ sender: Any) {
        var imgItems:[String]=[]
       let vail=wwvalidation()
        vail.view=self
        
        if titleField.text==""{
            vail.alert(title: "업로드 오류", text: "제목을 입력해주세요.")
            return}
        if textField.text==""{
            vail.alert(title: "업로드 오류", text: "부제목을 입력해주세요.")
            return}
        
        uploadItem.forEach { json in
           
            imgItems.append(json.rawString()!)
        }
       
        
        
        var param:Parameters=["title":titleField.text,"text":textField.text,"imgItems":imgItems,"x":avg_x,"y":avg_y,"do":l_do,"si":l_si,"dong":l_dong]
        wwhttp().postData(url: wwurl().getUploadFeed(), param: param, sFun: self.feedUploadSF, fFun: nil, ctrl: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.setNavigationBarHidden(false, animated: true)
   
        
        if uploadItem.count==0{
            self.dismiss(animated: true, completion: nil)
        }
        imgScrView.delegate=self
        imgScrView.isPagingEnabled=true
        
       
        pageC.numberOfPages=uploadImage.count
        pageC.currentPage=0
        setImages()
        setupScrView()
        
    }
    
    override func viewWillLayoutSubviews() {
        
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
       // let pagecon=self.parent?.parent as! pageController
       // pagecon.dataSource=nil
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
       // let pagecon=self.parent?.parent as! pageController
       // pagecon.dataSource=pagecon.self
    }
    
    func setImages(){
        
        for i in 0 ..< uploadImage.count{
            let img:imageController=Bundle.main.loadNibNamed("imageView", owner: self, options: nil)?.first as! imageController
            img.imgView.image=uploadImage[i]
            
            imgViews.append(img)
            
            //print(Double(uploadItem[i]["x"].rawString()!)!)
            avg_x+=Double(uploadItem[i]["x"].rawString()!)!
            avg_y+=Double(uploadItem[i]["y"].rawString()!)!
        }
        avg_x=(avg_x/Double(uploadItem.count))
        avg_y=(avg_y/Double(uploadItem.count))
        let geo=CLGeocoder()
        let local=Locale(identifier: "Ko-kr")
        geo.reverseGeocodeLocation(CLLocation(latitude: avg_x, longitude: avg_y), completionHandler: {
            (place,error) in
            self.l_do=place?.last?.administrativeArea
            self.l_si=place?.last?.locality
            self.l_dong=place?.last?.subLocality
            
        })
  
    }
    
    func setupScrView(){
        let w=mainView.frame.size.width
        let h=imgScrView.frame.size.height
        imgScrView.contentSize=CGSize(width: w*CGFloat(uploadImage.count), height: h)
        
        
        for i in 0..<uploadImage.count{
            imgViews[i].frame=CGRect(x: w*CGFloat(i), y: 0, width: w, height: h)
         
            
            imgScrView.addSubview(imgViews[i])
        }
        
    }
    

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    func feedUploadSF(){
      self.dismiss(animated: true, completion: nil)
        
      
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textFiled:UITextField)->Bool{
        textFiled.resignFirstResponder()
        return true
    }
}
