//
//  validation.swift
//  picmic
//
//  Created by mac on 2018. 9. 3..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit

class wwvalidation{
    
    var view:UIViewController!
    
    
    
    func emailCheck(text:String)->Bool{
        if !emailVaildation(email: text){
        alert(text: "이메일형식이 다릅니다.")
                   return false
        }
        return true
    }
    func nilCheck(name:String,field:UITextField)->Bool {
        if field.text==""{
            alert(text: name+"을 확인해 주세요.")
            return false
        }
        return true
    }
    
    func emailVaildation(email:String)->Bool{
        let emailReg="[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailCheck=NSPredicate(format: "SELF MATCHES %@", emailReg)
        
        return emailCheck.evaluate(with: email)
    }
 
    func passwordValidation(field:UITextField,fieldC:UITextField)->Bool{
        if !(field.text==fieldC.text){
            alert(text: "비밀번호가 일치하지 않습니다.")
            return false
        }
        return true
    }
    func alert(text:String){
        let alert=UIAlertController(title: "가입 오류", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default , handler: nil))
        view.present(alert, animated: true)
    }
    func alert(title:String,text:String){
        let alert=UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default , handler: nil))
        view.present(alert, animated: true)
    }
    
    
}
