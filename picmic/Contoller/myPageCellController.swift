//
//  imageView.swift
//  picmic
//
//  Created by mac on 2018. 12. 6..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class myMagazineCell:UICollectionViewCell{
    
    let stMyPage=ST_MYPAGE()
    let wwHttp=wwhttp()
    var rootController:UIViewController?
    var data:JSON?{
        didSet{
            loadImage(data: data!)
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    func loadImage(data:JSON){
        let param:Parameters=["feed_uid":data["feed_uid"].rawString()!]
        print(param)
        wwHttp.getImage(url: stMyPage.myfeedimage(), param: param){
            img,err in
            self.imageView.image=img
        }
        
    }
    
    @IBAction func cellBta(_ sender: Any) {
        let view = rootController?.storyboard?.instantiateViewController(withIdentifier: "EditFeedView") as! EditFeedController
        
        view.feedData=data!
        rootController?.navigationController?.pushViewController(view, animated: true)
        
        
        
        
        
        
 }
}
