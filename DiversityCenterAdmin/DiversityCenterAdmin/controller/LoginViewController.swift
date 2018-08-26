//
//  LoginViewController.swift
//  DiversityCenterAdmin
//
//  Created by Arrido Arfiadi on 8/25/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func signInPressed(_ sender: UIButton) {
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            self.performSegue(withIdentifier: "signIn", sender: self)
        }
    }
}
