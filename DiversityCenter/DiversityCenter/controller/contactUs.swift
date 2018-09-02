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
import SVProgressHUD
import Firebase

class contactUs: UIViewController {
    let loginManager = FBSDKLoginManager()
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognition: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognition)
    }
    
    
    
    @IBAction func signout(_ sender: UIBarButtonItem) {
        
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


    @IBAction func sendButton(_ sender: UIButton) {
        if textField.text == ""{
            let alert = UIAlertController(title: "Error", message: "Put in a message to send", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert,animated: true,completion: nil)
                return
        }
        let confirmAlert = UIAlertController(title: "Confirmation", message: "Send message?", preferredStyle: .alert)
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        confirmAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (alertAction) in
            //TODO: Send the message to Firebase and save it in our database
            SVProgressHUD.show()
            self.textField.endEditing(true)
            self.textField.isEditable = false
            let messageDB = Database.database().reference().child("messages")
            let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": self.textField.text!]
            messageDB.childByAutoId().setValue(messageDictionary){
                (error,reference) in
                
                if error != nil {
                    print(error!)
                }
                else {
                    print("message send")
                    self.textField.isEditable = true
                    self.textField.text = ""
                    SVProgressHUD.dismiss()
                    let alert = UIAlertController(title: "Message Sent", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                    self.present(alert,animated: true, completion: nil)
                }
            }
        }))
        self.present(confirmAlert,animated: true,completion: nil)
    }
    @objc func dismissKeyboard(){
        textField.endEditing(true)
    }
    
    

}

