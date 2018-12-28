//
//  editionCellController.swift
//  picmic
//
//  Created by mac on 2018. 12. 16..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
class editionCellController:UICollectionViewCell{
    let wwHttp=wwhttp()
    let wwUrl=wwurl()
    var rootContoller:UIViewController?
    var feedData:JSON?
    var cellData:JSON?{
        didSet{
    
            
            let param:Parameters=["feed_uid":cellData!["feed_uid"].rawString()]
            
            wwHttp.postData(url: wwUrl.getLoadFeed(), param:param ){
                res,err in
                self.titleLabel.text=res?[0]["title_text"].rawString()
                self.feedData=res![0]
                
            }
            
            wwHttp.postData(url: wwUrl.getloadfeedimage(), param: param){
                json,err in
                do{
                   
                    for (key,val) in json! {
                        let param:Parameters = ["folder_path":val["folder_path"],"image_uid":val["image_uid"]]
                        
                        self.wwHttp.getImage(url: self.wwUrl.getImage(), param: param){
                        img,err in
                            self.imageView.image=img
                            
                    }
                
                }
 
            }
         
        }
    }
    }
    var mainView:UIView?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var clickBta: UIButton!
    
    @IBAction func clickBt(_ sender: Any) {
        let view = rootContoller!.storyboard?.instantiateViewController(withIdentifier: "editionDetailView") as! editionDetailController

        view.cellData=self.feedData!
        rootContoller!.navigationController?.pushViewController(view, animated: true)
        
    }
    
    func showDial(){
        
    }
    
    func hideDial(){
        
    }
    
    
}
