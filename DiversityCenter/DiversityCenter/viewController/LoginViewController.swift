//
//  LoginViewController.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 6/3/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnFBLogin = FBSDKLoginButton()
        btnFBLogin.readPermissions = ["public_profile","email","user_friends"]
        //btnFBLogin.center = self.view.center
        btnFBLogin.frame = CGRect(x: 16, y: view.frame.height - 75, width: view.frame.width - 32, height: 50)
        //btnFBLogin.frame.origin = CGPoint(x: , y: 375)
        
        self.view.addSubview(btnFBLogin)
        btnFBLogin.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    func fetchProfile(){
        let parameters = ["fields": "first_name,last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath:"me", parameters: parameters).start { (connection, result, error) in
            let resultNew = result as? [String:Any]
            let name = resultNew!["first_name"]  as! String
            let last = resultNew!["last_name"]  as! String
            self.nameLabel.text = name + " " + last
            self.nameLabel.isHidden = false
            self.welcome.isHidden = false
            
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current()) != nil{
            self.performSegue(withIdentifier: "lobby", sender: self)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
