//
//  myPageEditController.swift
//  picmic
//
//  Created by mac on 2018. 12. 17..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class myPageEditController:UIViewController{
    
    let wwHttp=wwhttp()
    let wwUrl=wwurl()
    

    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var infoField: UITextView!
    
    
    
    @IBAction func backBt(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func saveBt(_ sender: Any) {
        print(infoField.text)
        let param:Parameters=["title_text":titleField.text,"info_text":infoField.text]
        wwHttp.postData(url: wwUrl.updateUser(), param: param){
            json,err in
             self.navigationController?.popToRootViewController(animated: true)
        }
        
       
    }
    
    
    override func viewDidLoad() {
        
        loadUserData()
        
    }
    
    func loadUserData(){
        let param:Parameters=[:]
        wwHttp.postData(url: wwUrl.getUser(), param: param){
            json,err in
            do{
                self.nameLabel.text=json!["user_name"].rawString()
                 self.titleField.text=json!["user_title"].rawString()
                 self.infoField.text=json!["user_+++++++info"].rawString()
            }
        }
        
    }
    
    
    
}
