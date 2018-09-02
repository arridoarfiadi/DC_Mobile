//
//  RoomsUiViewViewController.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 6/17/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SafariServices

class RoomsUiViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func signout(_ sender: UIBarButtonItem) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        self.performSegue(withIdentifier: "signout", sender: self)
    }
    @IBOutlet weak var tableView: UITableView!
    
    let roomNameArray = ["Meeting Room 1&2","Meeting Room 3", "Conference Room", "Multi-Purpose Room"]
    let roomImageArray = ["meeting1","round", "Conference" , "Lecture"]
    let roomCapArray = ["6","6", "12", "25"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "roomTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "roomCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as! roomTableViewCell
        cell.roomNameLabel.text = roomNameArray[indexPath.row]
        cell.roomCapLabel.text = roomCapArray[indexPath.row]
        cell.imageBox.image = UIImage(named: roomImageArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomNameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func reserveClicked(_ sender: UIButton) {
        let safari = SFSafariViewController(url: URL(string: "https://orgsync.com/159479/forms/261204")!)
        safari.modalPresentationStyle = .overFullScreen
        self.present(safari, animated: true, completion: nil)
        
    }
    
}
