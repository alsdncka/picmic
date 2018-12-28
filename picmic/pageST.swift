//
//  pageST.swift
//  picmic
//
//  Created by mac on 2018. 9. 13..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
struct pageST{
    init() {
        
    }
    lazy var orderedViewCtrl:[UIViewController] = {
        return [
            nextVc(view: "FeedView"),
            nextVc(view: "tabView"),
            nextVc(view: "LibraryView")
            
        ]}()
    
    func nextVc(view:String)->UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:view)
    }

}
