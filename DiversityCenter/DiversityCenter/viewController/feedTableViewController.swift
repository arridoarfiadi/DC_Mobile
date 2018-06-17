//
//  feedTableViewController.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 6/16/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

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
    var messages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        feedTable.dataSource = self
        feedTable.delegate = self
        feedTable.showAnimatedGradientSkeleton()
        fetchFeed()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }

    func fetchFeed(){
        let parameter = ["fields": "message"]
        FBSDKGraphRequest(graphPath:"487210354969549/posts?limit=100", parameters:parameter ).start { (connection, result, error) in
            let resultNew = result as? [String:Any]
            let data = resultNew!["data"] as! [Any]
            
            for feed in data{
                let test = feed as? [String:Any]
                let caption = test!["message"]
                if caption != nil{
                    self.messages.append(caption! as! String)
                    
                }
                
            }
            //print(self.messages)
            //self.feedTable.rowHeight = 300
            //self.feedTable.estimatedRowHeight = 300
            
            self.feedTable.reloadData()
            self.feedTable.hideSkeleton()
            
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCellTableViewCell
        cell.message.text = messages[indexPath.row]

        return cell
    }
    
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
