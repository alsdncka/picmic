//
//  feedController.swift
//  picmic
//
//  Created by mac on 2018. 9. 14..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class feedController:UIView{
    
    
    @IBOutlet weak var contView: UIStackView!
    
    var contData:JSON?{
        didSet{
      
           
            textSetting()
           
            imageSetting()
             editionSetting()
            
        }
    }
    var backgroundView:UIView!
    var dialogView:UIView!
    var tempText:String!
    let wwHttp=wwhttp()
    let wwUrl=wwurl()
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var moreButtom: UIButton!{
        didSet{
            moreButtom.isHidden=true
        }
    }
    
    
    @IBOutlet weak var barView: UIView!{
        didSet{
                barView.layer.borderWidth=3.0
            barView.layer.borderColor=UIColor.black.cgColor
        }
    }
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var textView: UIView!
    
    @IBOutlet weak var text: UITextView!{
        didSet{
            
        }
    }
    
    
    @IBOutlet weak var point: UILabel!
    

    @IBOutlet weak var srcView: UIScrollView!
    

    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var editionBta: UIButton!
    
    @IBAction func editionBt(_ sender: Any) {
        
        let param:Parameters=["feed_uid":contData!["feed_uid"].rawString()]
        wwhttp().postData(url: wwurl().setEdidtion(), param: param){
            json,err in
            do{
                switch json!["title"].rawString(){
                case "able" : self.editionBta.titleLabel?.textColor=UIColor.red
                case "unable" :
                    self.editionBta.titleLabel?.textColor=UIColor.lightGray
                default : self.editionBta.titleLabel?.textColor=UIColor.lightGray
                }
            }
            
        }
     
    }
    

    
    
    func textSetting(){
   
        title.text=contData!["title_text"].rawString()
        text.text=contData!["text_text"].rawString()
        name.text=contData!["user_name"].rawString()
                
     
    }
    func editionSetting(){
         let eParam:Parameters=["feed_uid":contData!["feed_uid"].rawString()]
        wwhttp().postData(url: wwurl().getCheckEdition(), param: eParam){
            json,err in
            //print(json)
            
            do{
                if (json!["count"]>0){
                    self.editionBta.titleLabel?.textColor=UIColor.red
                }else{
                    self.editionBta.titleLabel?.textColor=UIColor.lightGray
                }
            }
        }
    }

    
    var images:[JSON]=[]
    
    func imageSetting(){
       self.srcView.isPagingEnabled=true
        let param:Parameters=["feed_uid":contData!["feed_uid"].rawString()]

        wwHttp.postData(url: wwUrl.getloadfeedimage(), param: param){
            res,err in
            for (k,v) in res!{
                
                let param:Parameters=[
                    "image_uid":v["image_uid"].rawString()!
                    ,"folder_path":v["folder_path"].rawString()!
                ]
                
                self.wwHttp.getImage(url: self.wwUrl.getImage(), param: param ){
                    img,err in
                    let imageView:UIImageView=UIImageView()
                    imageView.frame=self.srcView.bounds
                    imageView.image=img
                    self.srcView.addSubview(imageView)
                    self.srcView.contentSize=self.srcView.bounds.size
                    
                }
                
                }
                
            }
            
        
        
        
        
     
        
    }
    
   
    @IBAction func moreAction(_ sender: Any) {
        dialog()
    }
    
    func dialog(){
        showDialog()
        
        

    }
    
    
    func showDialog(){
      
        backgroundView=UIView()
        dialogView=UIView()
          backgroundView.frame=self.contView.frame
     
        
        dialogView.frame=CGRect(x: 50, y: 50, width: self.contView.frame.size.width-100, height: self.contView.frame.size.height-100)
           backgroundView.backgroundColor=UIColor.black
        backgroundView.alpha=0
        dialogView.backgroundColor=UIColor.white
         dialogView.alpha=0
        
        dialogView.layer.cornerRadius=10
        
        dialogView.addSubview(self.createText(title:self.title.text!,text: self.text.text,view:dialogView))
        
        UIView.animate(withDuration: 0.33, animations: {
          
         
            self.backgroundView.alpha=0.6
            self.dialogView.alpha=1
          
            
            let tapGeust=UITapGestureRecognizer(target: self, action: #selector(self.hideDialog))
            
            self.backgroundView.addGestureRecognizer(tapGeust)
            
            self.contView.addSubview(self.backgroundView)
       self.contView.addSubview(self.dialogView)
        })
        
    }
    
    @objc func hideDialog(){
     self.dialogView.removeFromSuperview()
        self.backgroundView.removeFromSuperview()
        
    }
    
    func createText(title:String,text : String,view : UIView) -> UIView {
        /*
        let textView:UITextView=UITextView()
        textView.isEditable=false
        textView.text=text
        textView.frame=CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        textView.backgroundColor=UIColor.clear
        textView.textAlignment = .center
        textView.font = UIFont(name: "NotoSansKR-Medium", size: 13)
 */
        var textView=Bundle.main.loadNibNamed("feedDetailView", owner: self, options: nil)?.first as! feedDetailView
        textView.frame=CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        textView.text.text=tempText
        textView.title.text=title
        
        
        return textView
    }
    

    
    
    
}


