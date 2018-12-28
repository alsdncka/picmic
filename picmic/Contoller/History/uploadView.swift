//
//  uploadView.swift
//  picmic
//
//  Created by mac on 2018. 12. 13..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class uploadViewController:UIViewController,UITextViewDelegate{
    
    var data:JSON?{
        didSet{
           loadData()
        }
    }
    let wwHttp=wwhttp()
    let wwUrl=wwurl()
    let Util=wwUtil()
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var titleView: UIView!
    
    
    @IBOutlet weak var textView: UIView!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var textLabel: UITextView!
    
    
    @IBAction func sendUpload(_ sender: Any) {
        
        setParam()
    }
    
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden=true
        textLabel.delegate=self
        titleLabel.borderStyle=UITextField.BorderStyle.none
        textViewInit()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         viewInit()
    }
    
    func loadData(){
        let param:Parameters=["image_uid":data!["image_uid"].rawString()];
        wwHttp.getImage(url: wwUrl.getImage(), param: param){
            img,err in
            do{
                self.imageView.image=img
            }
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textLabel.textColor == UIColor.lightGray{
            textLabel.text=""
            textLabel.textColor=UIColor.black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textLabel.text.isEmpty{
            textViewInit()
        }
    }
    func viewInit(){
        
        
        
        Util.addBottomBorder(bview: titleView)
        
         Util.addBottomBorder(bview: textView)
    }
    
    func textViewInit(){
        textLabel.text="추천메뉴,Tip,가게이름 등 맛있는 공유해주세요."
        textLabel.textColor=UIColor.lightGray
        
    }
    
    func setParam(){
    
       var imgItems : [String]=[]
       imgItems.append(data!.rawString()!)
    
       
        let x=data!["x"].rawString()
        let y=data!["y"].rawString()
        let l_do=data!["do_text"].rawString()
        let l_si=data!["si_text"].rawString()
        let l_dong=data!["dong_text"].rawString()
   
       let param:Parameters=["title_text":titleLabel.text,"text_text":textLabel.text,"imgItems":imgItems,"x":x,"y":y,"do_text":l_do,"si_text":l_si,"dong_text":l_dong]
        

        wwHttp.postData(url: wwUrl.getUploadFeed(), param: param){
            res,err in
            if(res!["code"].rawString()=="SUCCESS"){
                self.feedUploadSF()
            }
        }
        
        
    }
    func feedUploadSF(){
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
}
