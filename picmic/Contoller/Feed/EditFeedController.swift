//
//  EditFeed.swift
//  picmic
//
//  Created by minwoo jung on 29/12/2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class EditFeedController:UIViewController{
    
    var feedData:JSON!{
        didSet{
            
        }
    }
    
    @IBAction func backBt(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func updateBt(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {

        
        
    }
    
    func setUp(){
        
    }
    
    
    
    
}
