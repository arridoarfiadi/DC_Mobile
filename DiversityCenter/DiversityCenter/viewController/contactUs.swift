//
//  FirstViewController.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 4/20/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import MessageUI
import FBSDKLoginKit

class contactUs: UIViewController {

    @IBAction func signout(_ sender: UIBarButtonItem) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        self.performSegue(withIdentifier: "signout", sender: self)
    }
    @IBAction func email(_ sender: Any) {
        let email = "uwbdiv@uw.edu"
        if let url = URL(string: "mailto:\(email)"){
            UIApplication.shared.open(url)
        }
    }
    @IBAction func callButton(_ sender: Any) {
        let url: NSURL = URL(string:"TEL://4253525030")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

