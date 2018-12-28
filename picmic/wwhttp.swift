//
//  wwhttp.swift
//  picmic
//
//  Created by mac on 2018. 9. 1..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON
import AlamofireImage

class wwhttp{
    var mainView:UIViewController?
   
   
    func postData(url:String){
        Alamofire.request(url, method: .post, encoding: JSONEncoding.default)
            .validate{ (req,res,data) in
                return .success
            }
            .responseJSON{
                res in print(res)
                
        }
        
    }
    
    func postData(url:String,param:Parameters,com:@escaping (JSON?,Error?)->()){
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
            .validate{ (req,res,data) in
            return .success
            }
            .responseJSON{
            res in
                do{
                    switch res.result {
                    case .success(let value):
                        let json=try JSON(data: res.data!)
                        com(json,nil)
                    case .failure(let error):
                        com(nil,error)
                    }
                }catch{
                    print("ERR : GETDATA")
                }
                
        }
       
    }
    
    func getData(url:String,com:@escaping (JSON?,Error?)->()){
        Alamofire.request(url, method: .post, encoding: JSONEncoding.default).responseJSON{
            res in
            do{
                switch res.result {
                case .success(let value):
                    let json=try JSON(data: res.data!)
                    com(json,nil)
                case .failure(let error):
                    com(nil,error)
                }
            }catch{
                print("ERR : GETDATA")
            }
        }
    }
    
    
    func getImage(url:String,param:Parameters,com:@escaping (Image?,Error?)->()){
        
       
       
        Alamofire.request(url,method: .post,parameters:param).responseImage{
            res in
            do{
                switch res.result{
                case .success(let value):
                        com(value,nil)
                case .failure(let err):
                        com(nil,err)
                }
            }catch{
                print("ERR IMAGE")
            }
        }
        
    }
    

    
 
    
    func postData(url:String,param:Parameters,sFun:(()->Void)?,fFun:(()->Void)?,ctrl:UIViewController){
        
      
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON{
                res in
                do{
                let json=try JSON(data: res.data!)
                    print(json)
                    if json["type"].string=="alert" {
                         wwUtil(view: ctrl).alert(title: json["title"].string!, text: json["message"].string!)
                    }
                    if json["code"].string=="success" {
                        
                       sFun?()
                    }else if json["code"].string=="cookie"{
                        if let field = res.response?.allHeaderFields as? [String:String]{
                            let cookies = HTTPCookie.cookies(withResponseHeaderFields: field, for: (res.response?.url!)!)
                     
                            HTTPCookieStorage.shared.setCookies(cookies, for: (res.response?.url!)!, mainDocumentURL: nil)
                            print("C")
                        }
                         sFun?()
                        print("C")
                    }
                    else{
                        
                        fFun?()
                        print("C")
                    }
                    
                    
                    
                }catch{
                    print("err")
                }
          
                
                
                
                
        }
        
    }
    
    func uploadImage(url:String,imageData:Data,X:String,Y:String,l_do:String,l_si:String,l_dong:String,ctrl:UIViewController){
        Alamofire.upload(multipartFormData: {
            (MultipartFormData) in
         //   MultipartFormData.append(HTTPCookieStorage.shared.cookies[""], withName: "text")
            MultipartFormData.append(imageData, withName: "image", fileName: "image.jpeg", mimeType: "image/jepg")
            MultipartFormData.append(X.data(using: String.Encoding.utf8)!, withName: "X")
            MultipartFormData.append(Y.data(using: String.Encoding.utf8)!, withName: "Y")
            
            MultipartFormData.append(l_do.data(using: String.Encoding.utf8)!, withName: "do")
            MultipartFormData.append(l_si.data(using: String.Encoding.utf8)!, withName: "si")
            MultipartFormData.append(l_dong.data(using: String.Encoding.utf8)!, withName: "dong")
            
        }, to: url,method:.post,headers:["Content-type":"multipart/form-data"]){
            (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON{res in
                    do{
                        let json=try JSON(data: res.data!)
                        print(json)
                        if json["type"].string=="alert" {
                            wwUtil(view: ctrl).alert(title: json["title"].string!, text: json["message"].string!)
                        }
                        
                        if json["code"].string=="success" {
                            
                          
                            
                        }
                        else{
                            
                            
                        }
                        
                        
                        
                    }catch{
                        print("err")
                    }
                }
                
            case .failure(let error):
                print("ERROR : ")
                print(error)
                
                
            }
        }
    }
    
   
    
    func getPhoto(uid:String)->Data?{
        
        let url=URL(string: "http://180.224.166.87:3000/pic/getimage?imgname="+uid )
        var req=URLRequest(url: url!)
        req.httpMethod="GET"
        let session=URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: req){
            (data,res,error) in
            DispatchQueue.main.async {
                print(data)
              
            }
            }.resume()
        return nil

    }
    
    func setCookie(cookies:[HTTPCookie],url:URL){
    Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookies(cookies, for: url, mainDocumentURL: nil)
    }
    
    func checkCookie(url:String,sFun:(()->Void)?,fFun:(()->Void)?,ctrl:UIViewController){
        Alamofire.request(url, method: .post, encoding: JSONEncoding.default)
            .validate{ (req,res,data) in
                return .success
            }
            .responseJSON{
                res in
                do{
                    let json=try JSON(data: res.data!)
                    
                    if json["type"].string=="alert" {
                        wwUtil(view: ctrl).alert(title: json["title"].string!, text: json["message"].string!)
                    }
                    
                    if json["code"].string=="success" {
                        
                        sFun?()
                        
                    }else if json["code"].string=="cookie"{
                        if let field = res.response?.allHeaderFields as? [String:String]{
                            let cookies = HTTPCookie.cookies(withResponseHeaderFields: field, for: (res.response?.url!)!)
                            print(cookies)
                            HTTPCookieStorage.shared.setCookies(cookies, for: (res.response?.url!)!, mainDocumentURL: nil)
                        }
                        sFun?()
                    }
                    else{
                        
                        fFun?()
                    }
                    
                    
                    
                }catch{
                    print("err")
                }
                
        }
    }
    
    
    
    func delCookies(){
        let cookie = HTTPCookie.self
        let cookiejar=HTTPCookieStorage.shared
        
        for cookie in cookiejar.cookies!{
            cookiejar.deleteCookie(cookie)
        }
    }
}
