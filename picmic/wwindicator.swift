//
//  wwindicator.swift
//  picmic
//
//  Created by mac on 2018. 9. 4..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
class wwindicator{
    var Cview:UIView=UIView()
    var loadingView:UIView=UIView()
    var actInd:UIActivityIndicatorView=UIActivityIndicatorView()
    var view:UIView=UIView()
    
    init(view:UIView) {
        self.view=view
    Cview.frame=view.frame
        Cview.center=view.center
        Cview.backgroundColor=UIColor(displayP3Red: 0.0, green: 0, blue: 0, alpha: 0.3)
        
        loadingView.frame=CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center=view.center
        loadingView.backgroundColor=UIColor(displayP3Red: 200/255, green: 200/255, blue: 200/255, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        actInd.frame=CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.style=UIActivityIndicatorView.Style.whiteLarge
        actInd.center=CGPoint(x: loadingView.frame.size.width/2, y: loadingView.frame.size.height/2)
        loadingView.addSubview(actInd)
        Cview.addSubview(loadingView)
    }
    
    func startInd(){
        view.addSubview(Cview)
        actInd.startAnimating()
    }
    
    func stopInd(){
        
        actInd.stopAnimating()
        Cview.removeFromSuperview()
    }
}
