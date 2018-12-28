//
//  editionDetailController.swift
//  picmic
//
//  Created by mac on 2018. 12. 17..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class editionDetailController:UIViewController{
    
    var feedCont:feedController?
    @IBOutlet weak var mainView: UIView!
    
    var cellData:JSON?{
        didSet{
          print(cellData)
            
        }
    }
    
    override func viewDidLoad() {
      
        
        feedCont=Bundle.main.loadNibNamed("feedViewController", owner: self, options: nil)?.first as! feedController
        feedCont!.contData=cellData
      
        mainView.addSubview(feedCont!)
    }
    override func viewDidLayoutSubviews() {
          feedCont!.frame=mainView.bounds
    }
    
    
    
    @IBAction func backBt(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
