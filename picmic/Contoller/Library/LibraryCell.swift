//
//  LibraryCell.swift
//  picmic
//
//  Created by mac on 2018. 9. 10..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class LibraryCell:UICollectionViewCell{
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    

    var image:JSON?{
        didSet{

           wwUtil().setupImage(imgUid: image!["uid"].rawString()!, imgPath: image!["path"].rawString()!, imgView: imageView)
            setLabel()
        }
    }
    var select:Bool?{
        didSet{
            updateLabel()
        }
    }
    
    
    func setLabel(){
        self.label.layer.borderWidth=1.0
        self.label.layer.cornerRadius=10
        self.label.layer.borderColor=UIColor.lightGray.cgColor
        
    }
    
    func updateLabel(){
        if select! {
    self.label.layer.borderColor=UIColor.blue.cgColor
            self.label.layer.backgroundColor=UIColor.white.cgColor
        }else{
            self.label.layer.borderColor=UIColor.lightGray.cgColor
            self.label.layer.backgroundColor=UIColor.clear.cgColor
        }
    }
 
}
