//
//  LibraryViewController.swift
//  picmic
//
//  Created by mac on 2018. 9. 5..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class LibraryViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
   
    
    @IBOutlet weak var uploadFBt: UIButton!
    
    
    @IBOutlet weak var collView: UICollectionView!
    
    var selectedPhoto : [JSON]=[]{
        didSet{
         updateSelectedStatue()
        }
    }
    
    var http:wwhttp=wwhttp()
    var cells:[JSON]=[]
    var selImg:[UIImage]=[]
    var selItem:[JSON]=[]
    var lastSelectIndex:IndexPath?

    
    @IBOutlet var mainView: UIView!
    
    @IBAction func cancelBt(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let w=mainView.frame.width/3
        
        let floatL:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        floatL.itemSize=CGSize(width: w-1, height: w-1)
        floatL.minimumInteritemSpacing=0
        floatL.minimumLineSpacing=1
        floatL.scrollDirection = .vertical
       collView.collectionViewLayout=floatL
        collView.allowsMultipleSelection=false
        getLibrary()
        collView.reloadData()
           self.navigationController?.setNavigationBarHidden(true, animated: false)
      
    }
 
    override func viewWillLayoutSubviews() {
     
    }
    @IBAction func sendDetail(_ sender: UIButton) {
        if selectedPhoto.count>0{
            let stroyBoard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            let vc=storyboard?.instantiateViewController(withIdentifier: "uploadDetail") as! uploadDetailViewController
           vc.uploadImage=selImg
            vc.uploadItem=selItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
   
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.lastSelectIndex != nil {
        let last_cell=collView.cellForItem(at: self.lastSelectIndex!) as! LibraryCell
        last_cell.select=false
        }
        let cell=collView.cellForItem(at: indexPath) as! LibraryCell
       cell.select=true
        
      
        selectedPhoto=[cells[indexPath.row]]
 
        selImg=[cell.imageView.image!]
     
        selItem=[cells[indexPath.row]]
        lastSelectIndex=indexPath
 
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell=collView.cellForItem(at: indexPath) as! LibraryCell
        cell.select=false
        
        selectedPhoto.remove(at: selectedPhoto.index(of: cells[indexPath.row])!)
        selImg.remove(at: selImg.index(of: cell.imageView.image!)!)
        selItem.remove(at: selItem.index(of: cells[indexPath.row])!)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return cells.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->UICollectionViewCell {

        let cell=collView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LibraryCell
       
        cell.image=cells[indexPath.row]
        cell.select=cell.isSelected
      
        return cell
    }
 
 
 
  
    
 
    func updateSelectedStatue(){
        if selectedPhoto.count>0{
            uploadFBt.setTitleColor(UIColor.black, for: .normal)
        }else{
              uploadFBt.setTitleColor(UIColor.lightGray, for: .normal)
        }
        print(selectedPhoto.count)
        uploadFBt.setTitle("선택["+String(selectedPhoto.count)+"]", for: .normal)
    }
   
    func getLibrary(){
        
        Alamofire.request(wwurl().getMyImage(), method: .post, parameters: nil, encoding:JSONEncoding.default).responseJSON{
            res in
            do{
                let json=try JSON(data: res.data!)
          
                self.cells=json.array!
                self.collView.reloadData()
                
                
            }catch{
                
            }
        }
        
    }
  
    
    
    
}

