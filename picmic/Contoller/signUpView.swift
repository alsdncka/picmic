//
//  signUp.swift
//  picmic
//
//  Created by mac on 2018. 9. 1..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class signUpView:UIViewController,UITextFieldDelegate
{
  

    

    @IBOutlet weak var signupButton: UIButton!
    
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var emailTxt: UITextField!{didSet{emailTxt.delegate=self
        }}
    @IBOutlet weak var nicknameTxt: UITextField!{didSet{nicknameTxt.delegate=self}}
    @IBOutlet weak var passwordTxt: UITextField!{didSet{passwordTxt.delegate=self}}
    @IBOutlet weak var passwordCTxt: UITextField!{didSet{passwordCTxt.delegate=self}}

    
    let http=wwhttp();
    let vali=wwvalidation();
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.tintColor=UIColor.black
        http.mainView=self
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        signupButton.layer.cornerRadius=5
        emailTxt.borderStyle=UITextField.BorderStyle.roundedRect
        
        wwUtil().addBottomBorder(bview: titleView)
        
    }
    
    @IBAction func signupBt(_ sender: UIButton) {

        
       vali.view=self
        if !vali.emailCheck(text: emailTxt.text!) {return}
       if !vali.nilCheck(name: "이름", field: nicknameTxt){return}
        if !vali.nilCheck(name: "비밀번호", field: nicknameTxt){return}
        if !vali.nilCheck(name: "비밀번호 확인", field: nicknameTxt){return}
        if !vali.passwordValidation(field: passwordTxt, fieldC: passwordCTxt){return}
 
        
        
        
        http.postData(url:wwurl().getAddUser(),param: userST(email: emailTxt.text, name: nicknameTxt.text, password: passwordTxt.text).getParam()){
            res,err in
            print(res)
            if(res!["code"].rawString()=="SUCCESS"){
                self.signonF()
            }else{
                
            }
        }
        
        
        
        
        
    }
    func signonF(){
        http.postData(url:wwurl().getSignon(),param: userST(email: emailTxt.text, name: nicknameTxt.text, password: passwordTxt.text).getParam()){
            res,err in
            if(res!["code"].rawString()=="SUCCESS"){
                self.signonMF()
            }else{
                
            }
        }
    }
    
    func signonMF(){
        self.performSegue(withIdentifier: "signupToPage", sender: self)
    }
    
   
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textFiled:UITextField)->Bool{
        textFiled.resignFirstResponder()
        return true
    }
    
}
