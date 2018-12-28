//
//  rootController.swift
//  picmic
//
//  Created by mac on 2018. 9. 4..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class rootController:UIViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        let param:Parameters=[:]
        wwhttp().postData(url: wwurl().getSignCheck(), param: param){
            res,err in
            if(res!["code"].rawString()=="SUCCESS"){
                
                 self.performSegue(withIdentifier: "rootToPage", sender: self)
            }else{
                
                self.performSegue(withIdentifier: "rootToSign", sender: self)
            }
        }
        
        
        
        
        
    }
    

}
