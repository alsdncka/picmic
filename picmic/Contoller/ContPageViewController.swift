//
//  ContPageViewController.swift
//  picmic
//
//  Created by mac on 2018. 9. 8..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit

class ContPageViewController:UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UITabBarDelegate{
    lazy var orderedViewCtrl:[UIViewController] = {
        return [
            self.getVc(view: "PhotoView"),
      
            
        ]}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource=self
        
        setViewControllers([orderedViewCtrl[0]], direction: .forward, animated: false, completion: nil)
        
        
    }

    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("A")
    }

    
    func getVc(view:String)->UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:view)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
     
        
        return nil
    }
        
}
