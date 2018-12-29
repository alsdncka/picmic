//
//  myMagazine.swift
//  picmic
//
//  Created by mac on 2018. 9. 23..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class myMagazineViewController:UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var nameBox: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var infoTextView: UITextView!
    
    @IBOutlet weak var countView: UIView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    @IBOutlet weak var coll: UICollectionView!
    
     let wwHttp=wwhttp()
    let wwUrl=wwurl()
    var uName:String?
    var uTitle:String?
    var uInfo:String?
    var uEmail:String?
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let border = CALayer()
        
        coll.delegate=self
        coll.dataSource=self
        
      
        
    }
    
    var cellData:[JSON]=[]
    
    override func viewDidLayoutSubviews() {
      
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let w=mainView.frame.width/4
        
        let floatL:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        floatL.itemSize=CGSize(width: w-1, height: w-1)
        floatL.minimumInteritemSpacing=0
        floatL.minimumLineSpacing=1
        floatL.scrollDirection = .vertical
        coll.collectionViewLayout=floatL

        setUserInfo()
       
     
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        cellData.removeAll()
    }
    
    func getUserData(json:JSON){
        
    }
    
    func setJson(){
        
        
    }
    
    func setUserInfo(){
        wwHttp.getData(url:wwUrl.getUser()){
            json,err in
            if(err==nil){
                self.nameLabel.text=json?["user_name"].rawString()
                
                self.titleLabel.text=json?["user_title"].rawString()?.replacingOccurrences(of: "null", with: "")
                print(json?["user_info"].rawString())
                self.infoTextView.text=json?["user_info"].rawString()?.replacingOccurrences(of: "null", with: "")
                self.uEmail=json?["user_email"].rawString()
                
               
                self.wwHttp.getData(url:self.wwUrl.getLoadMyFeeds()){
                    json,err in
                    self.countLabel.text=String(json!.count)
                    for (key,val) in json!{
                        
                        self.cellData.append(val)
                        
                        
                        
                        
                    }
                    
                       self.coll.reloadData()
                }
             
           
               
                
            
                
                
            }
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       
        return self.cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
     
        let cell=self.coll.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            as! myMagazineCell
        cell.rootController=self
        
        
        cell.data=self.cellData[indexPath.row]
      return cell
    
        
        
    }
    
}
