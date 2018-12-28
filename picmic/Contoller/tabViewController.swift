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
        
        if viewController is LibraryViewController{
            let vc=self.storyboard?.instantiateViewController(withIdentifier: "LibraryView")
            self.present(vc!, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    
    
}
