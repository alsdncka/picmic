//
//  userST.swift
//  picmic
//
//  Created by mac on 2018. 9. 2..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import Alamofire

struct userST{
    var email:String?
    var uid:String?
    var name:String?
    var signdata:String?
    var password:String?
    
    init(uid:String?,email:String?,name:String?,password:String?,signdata:String?) {
        self.email=email
        self.uid=uid
        self.name=name
        self.signdata=signdata
        self.password=password
    }
    init(email:String?,name:String?,password:String?) {
        self.email=email
        self.name=name
        self.password=password
    }
    init(email:String?,password:String?) {
        self.email=email
        self.password=password
    }
    init(){
        
    }
    func getParam()->Parameters{
        let param:Parameters=["user_uid":self.uid,"user_email":self.email,"user_name":self.name,"sign_data":self.signdata,"user_password":self.password?.sha256()]
        return param
    }
    
    func getUid()->String{
        return self.uid!
    }
    func getName()->String{
        return self.name!
    }
    func getEmail()->String{
        return self.email!
    }
    func getSigndata()->String{
        return self.signdata!
    }

    
  
    
    
}
extension String{
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
}
