//
//  MyMagazineController.swift
//  picmic
//
//  Created by mac on 2018. 12. 10..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


class MyMagazineController:UIViewController{
    
    let wwHttp=wwhttp()
    let wwUrl=wwurl()
    
    override func viewDidLoad() {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func loadData(){
        wwHttp.getData(url: wwUrl.getedition){
            json,err in
            do{
                
            }
        }
        
    }
    
    
}
