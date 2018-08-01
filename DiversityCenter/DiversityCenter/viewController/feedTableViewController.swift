//
//  feedTableViewController.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 6/16/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import SafariServices
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SkeletonView

class feedTableViewController: UITableViewController {

    @IBAction func signout(_ sender: UIBarButtonItem) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        self.performSegue(withIdentifier: "signout", sender: self)
    }
    
    @IBOutlet var feedTable: UITableView!
    

    
    
    
    var feed : [Feed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTable.dataSource = self
        feedTable.delegate = self
        feedTable.showAnimatedGradientSkeleton()
        fetchFeed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }

    func fetchFeed(){
        let parameter = ["fields": "message, created_time, description, link"]
        FBSDKGraphRequest(graphPath:"487210354969549/posts?limit=100", parameters:parameter ).start { (connection, result, error) in
            if error != nil {
                print(error)
                return
            }
            let resultNew = result as? [String:Any]
            let data = resultNew!["data"] as! [Any]
            
            for feed in data{
                let test = Feed(singleFeed: feed as! [String : Any])
                if test.getMessage() != "NOT"{
                    self.feed.append(test)
                }
                
                
                
            }
            //self.feedTable.rowHeight = 300
            //self.feedTable.estimatedRowHeight = 300
            
            self.feedTable.reloadData()
            self.feedTable.hideSkeleton()
            
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCellTableViewCell
        cell.postFeed = feed[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let safari = SFSafariViewController(url: URL(string: feed[indexPath.row].getLink())!)
        self.present(safari, animated: true, completion: nil)
    }
}
