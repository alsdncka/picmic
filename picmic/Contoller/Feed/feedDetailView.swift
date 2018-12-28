//
//  feedDetailView.swift
//  picmic
//
//  Created by mac on 2018. 10. 23..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit

class feedDetailView:UIView {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var titleView: UIView!{
        didSet{
            wwUtil().addBottomBorder(bview: titleView)
        }
    }
    
    @IBOutlet weak var text: UITextView!
    
}
