//
//  pageController.swift
//  picmic
//
//  Created by mac on 2018. 9. 3..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit

class pageController:UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate{
    lazy var orderedViewCtrl:[UIViewController] = {
        return [
            self.nextVc(view: "PhotoView"),
            self.nextVc(view: "TabView"),
            self.nextVc(view: "MapView")
        
        ]}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource=self
        
        setViewControllers([orderedViewCtrl[1]], direction: .forward, animated: false, completion: nil)
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func nextVc(view:String)->UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:view)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewIndex=orderedViewCtrl.index(of:viewController){
            if viewIndex>0{
                //print(viewIndex)
                return orderedViewCtrl[viewIndex-1]
            }else{
                return nil
            }
        }
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewIndex=orderedViewCtrl.index(of:viewController){
            if viewIndex<orderedViewCtrl.count-1{
                return orderedViewCtrl[viewIndex+1]
            }else{
                return nil
            }
        }
        
        return nil
    }
    
    
}


