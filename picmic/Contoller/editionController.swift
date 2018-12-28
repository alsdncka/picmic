//
//  editionController.swift
//  picmic
//
//  Created by mac on 2018. 12. 16..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class editionController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    let wwHttp=wwhttp()
    let wwUrl=wwurl()
    
    var cellData:[JSON]=[]
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var mainView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate=self
        self.collectionView.dataSource=self
        viewInit()
        
        
        
        wwHttp.getData(url: wwUrl.loadEdition()){
            json,err in
       
            for (key,val) in json!{
                self.cellData.append(val)
                }
                   self.collectionView.reloadData()
        }
 
    }
    
    func viewInit(){
        let w = mainView.frame.width/2
        let floatL:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        floatL.itemSize=CGSize(width: w-1, height: w*1.2)
        floatL.minimumInteritemSpacing=0
        floatL.minimumLineSpacing=1
        floatL.scrollDirection = .vertical
        collectionView.collectionViewLayout=floatL
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
 
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "editionCell", for: indexPath) as! editionCellController
        
            cell.rootContoller=self
        
        
        
        
        
        
        
        
            cell.cellData = cellData[indexPath.row]
        cell.mainView=mainView
        
        return cell
        
    }
    
    
    
    
}
