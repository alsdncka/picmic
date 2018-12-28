//
//  HistoryController.swift
//  picmic
//
//  Created by mac on 2018. 12. 9..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


class HistroyController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
     let wwHttp=wwhttp()
    let wwUrl=wwurl()
    var cellData:[JSON]=[]
    
    var selectCell:HistoryCell?
    var selectCellData:JSON?
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var collView: UICollectionView!
    
    override func viewDidLoad() {
        collView.delegate=self
        collView.dataSource=self
      
        
    }
    
    @IBOutlet weak var selectBta: UIButton!
    
    @IBAction func selectBt(_ sender: Any) {

        let view = storyboard?.instantiateViewController(withIdentifier: "uploadView") as! uploadViewController
        view.data=selectCellData
      let navi=UINavigationController(rootViewController: view)
        present(navi,animated: true,completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cellData.removeAll()
        collView.reloadData()
        selectBta.isHidden=true;
        
        let w=mainView.frame.width/4
        
        let floatL:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        floatL.itemSize=CGSize(width: w-1, height: w-1)
        floatL.minimumInteritemSpacing=0
        floatL.minimumLineSpacing=1
        floatL.scrollDirection = .vertical
        collView.collectionViewLayout=floatL
        wwHttp.getData(url: wwUrl.getMyImage()){
            json,err in
            do{
                for(key,val) in json!{
                    self.cellData.append(val)
                }
                
                
                self.collView.reloadData()
            }catch{
                print("ERR HISTORY1")
            }
        }
     setLayout()
    }
    
    func setLayout(){
        selectBta.layer.borderWidth=1
        selectBta.layer.borderColor=UIColor.black.cgColor
        selectBta.layer.cornerRadius=3
    }
    
    override func viewDidLayoutSubviews() {
    
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell=collView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath) as! HistoryCell
        
        
        cell.data=self.cellData[indexPath.row]
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header=collView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collHeader", for: indexPath) as! HistoryHeader
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collView.cellForItem(at: indexPath) as! HistoryCell
        
        if(cell.selector==true){
            cell.selector=false
            selectCell=nil
            selectCellData=nil
        }else{
        
        selectCell?.selector=false
        cell.selector=true
        selectCell=cell
            selectCellData=cellData[indexPath.row]
            
        }
        buttonEvent()
    }
    
    func buttonEvent(){
        if(selectCell != nil){
            selectBta.isHidden=false
        }else{
            selectBta.isHidden=true
        }
    }
    
    
    
    
    
    
}
