//
//  LoginViewController.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 6/3/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SVProgressHUD


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {


    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //things to do after button is clicked
        SVProgressHUD.show()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //things to do after log out button is clicked
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //make facebook button
        let btnFBLogin = FBSDKLoginButton()
        btnFBLogin.readPermissions = ["public_profile","email","user_friends"]
        btnFBLogin.frame = CGRect(x: 16, y: view.frame.height - 75, width: view.frame.width - 32, height: 50)
        self.view.addSubview(btnFBLogin)
        btnFBLogin.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    func fetchProfile(){
        //get first and last name
        let parameters = ["fields": "first_name,last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath:"me", parameters: parameters).start { (connection, result, error) in
            //let resultNew = result as? [String:Any]
            //let name = resultNew!["first_name"]  as! String
            //let last = resultNew!["last_name"]  as! String
            //self.nameLabel.text = name + " " + last
            //self.nameLabel.isHidden = false
            //self.welcome.isHidden = false
            
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current()) != nil{
            //goes to home screen if logged in
            self.performSegue(withIdentifier: "lobby", sender: self)
        }
    }
    
}
