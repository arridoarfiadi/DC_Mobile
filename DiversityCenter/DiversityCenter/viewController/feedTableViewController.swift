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
import ChameleonFramework
import SwipeCellKit


class feedTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    @IBAction func signout(_ sender: UIBarButtonItem) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        self.performSegue(withIdentifier: "signout", sender: self)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var feedTable: UITableView!
    var feed : [Feed] = []
    var feedSearch: [Feed] = []
    var inSearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        feedTable.showAnimatedGradientSkeleton()
        fetchFeed()
        searchBar.delegate = self
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearch{
            return feedSearch.count
        }
        return feed.count
    }

    func fetchFeed(){
        let parameter = ["fields": "message, created_time, description, link"]
        FBSDKGraphRequest(graphPath:"487210354969549/posts?limit=100", parameters:parameter ).start { (connection, result, error) in
            if let errorMessage = error {
                print(errorMessage)
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
        if inSearch{
            cell.postFeed = feedSearch[indexPath.row]
        }
        else{
            cell.postFeed = feed[indexPath.row]
        }
        
        //cell.backgroundColor = UIColor(hexString: "4A3878")?.darken(byPercentage: (CGFloat(indexPath.row) / CGFloat(feed.count)))
        cell.backgroundColor = .white
        cell.delegate = self
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let safari = SFSafariViewController(url: URL(string: feed[indexPath.row].getLink())!)
        safari.modalPresentationStyle = .overFullScreen
        self.present(safari, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .default, title: "Favorites") { action, indexPath in
            // handle action by updating model with deletion
            
        }
        // customize the action appearance
        deleteAction.backgroundColor = UIColor(hexString: "b7a57a")
        deleteAction.image = UIImage(named: "literature")
        deleteAction.textColor = .black
        
       
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .selection
        options.transitionStyle = .reveal
        return options
    }
}

extension feedTableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count != 0{
            feedSearch = feed.filter({ return ($0.getMessage().contains(searchBar.text!))})
            inSearch = true
            tableView.reloadData()
        }
        else {
            inSearch = false
            tableView.reloadData()
        }
    }
    
}
