//
//  HistoryCell.swift
//  picmic
//
//  Created by mac on 2018. 12. 9..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
class HistoryCell:UICollectionViewCell{
    
    let wwUrl=wwurl()
    let wwHttp=wwhttp()
    
    var data:JSON?{
        didSet{
            loadImage(data: data!)
        }
    }
    
    var selector:Bool?{
        didSet{
            if selector!{
                selectItem()
            }else{
                deSelectItem()
            }
        }
    }
    
    @IBOutlet weak var selectorLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    func loadImage(data:JSON){
        do{
       
            let param:Parameters=[
                "image_uid":data["image_uid"].rawString()!
                ,"folder_path":data["folder_path"].rawString()!
            ]
            
            wwHttp.getImage(url: wwUrl.getImage(), param: param){
                res,err in
                self.imageView.image=res
            }
            
            
        
          setLabel()
     
        }
    }
    
    func setLabel(){
        let label = selectorLabel.layer
        label.borderWidth=1.0
        label.cornerRadius=10
        label.borderColor=UIColor.lightGray.cgColor
        
    }
    
    
    func selectItem(){
        let label = selectorLabel.layer
        label.backgroundColor=UIColor.white.cgColor
        label.borderColor=UIColor.white.cgColor
    }
    
    func deSelectItem(){
        let label = selectorLabel.layer
        label.backgroundColor=UIColor.clear.cgColor
        label.borderColor=UIColor.lightGray.cgColor
    }
    
}
