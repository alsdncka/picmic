//
//  tabViewController.swift
//  picmic
//
//  Created by mac on 2018. 9. 8..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit

class tabViewController:UITabBarController,UITabBarControllerDelegate{
    
    @IBOutlet weak var cont: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //tabBar.delegate=ContPageViewController()
        self.selectedIndex=0
        self.delegate=self
    }
    

   override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
    
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let class_name=String(describing: viewController.classForCoder)
        
        if ( class_name == "FeedViewController") {
            let view = viewController as! FeedViewController
            print(view.viewStatus)
         
        }else if ( class_name == "HistroyController"){
            
        }else if ( class_name == "editionController"){
            
        }else if ( class_name == "myPageViewController"){
            
        }
        
        
        return true
    }
    
    
    
}
