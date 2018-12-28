//
//  testClass.swift
//  picmic
//
//  Created by mac on 2018. 9. 1..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit

class testClass:UIView{
    var view:UIViewController?
    
    func test(){
        
        view!.performSegue(withIdentifier: "test", sender: nil)
    }
    
    
}
