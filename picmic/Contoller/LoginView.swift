//
//  ViewController.swift
//  picmic
//
//  Created by mac on 2018. 9. 1..
//  Copyright © 2018년 mac. All rights reserved.
//

import UIKit

class LoginView: UIViewController {


    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet var mainView: UIView!
    let vali=wwvalidation();
    
    @IBOutlet weak var sigonButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var signupView: UIView!
    
    @IBAction func signonBt(_ sender: UIButton) {
        
        if !vali.nilCheck(name: "이메일", field: emailTxt){return}
        if !vali.emailCheck(text: emailTxt.text!) {return}
        if !vali.nilCheck(name: "비밀번호", field: passwordTxt){return}
        
        
        
        wwhttp().postData(url: wwurl().getSignon(), param: userST(email: emailTxt.text, password: passwordTxt.text).getParam()){
            res,err in
            if(res!["code"].rawString()=="SUCCESS"){
                   self.performSegue(withIdentifier: "signToPage", sender: self)
            }
            
        }
        
      
        
    }
    
   
    

    
    override func viewDidLoad() {
                super.viewDidLoad()
        let ind=wwindicator(view:mainView)
        ind.startInd()
        ind.stopInd()
        vali.view=self
        
       emailTxt.borderStyle=UITextField.BorderStyle.none
        passwordTxt.borderStyle=UITextField.BorderStyle.none
       sigonButton.layer.borderWidth=1.0
        sigonButton.layer.cornerRadius=15
        sigonButton.layer.borderColor=UIColor.gray.cgColor
        
    }

    override func viewDidLayoutSubviews() {
        
    wwUtil().addBottomBorder(bview: emailView)
    wwUtil().addBottomBorder(bview: passwordView)
    wwUtil().addTopBorder(bview: signupView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textFiled:UITextField)->Bool{
        textFiled.resignFirstResponder()
        return true
    }
}

