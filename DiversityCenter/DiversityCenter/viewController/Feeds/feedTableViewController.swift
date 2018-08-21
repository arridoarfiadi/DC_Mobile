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
import RealmSwift



class feedTableViewController: UITableViewController, SwipeTableViewCellDelegate {


    //sign out button
    @IBAction func signout(_ sender: UIBarButtonItem) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        self.performSegue(withIdentifier: "signout", sender: self)
    }
    
    @IBAction func bookmarkButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToBookmark", sender: self)
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var feedTable: UITableView!
    
    
    //Realm
    let realm = try! Realm()
    var bookmarkArray: Results<Feed>?
    
    
    
    
    
    //Setup arrays
    var feed : [Feed] = []
    var feedSearch: [Feed] = []
    //Search bool
    var inSearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBookmarked()
        setupUI()
        fetchFeed()
        searchBar.delegate = self
    }
    
    func setupUI(){
        //All UI changes
        //tableView.separatorStyle = .none
        feedTable.showAnimatedGradientSkeleton()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of rows
        if inSearch{
            return feedSearch.count
        }
        return feed.count
    }
    
    //fecthing from facebook graph api
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
        //Setting up each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCellTableViewCell
        if inSearch{
            cell.postFeed = feedSearch[indexPath.row]
        }
        else{
            cell.postFeed = feed[indexPath.row]
        }
        
        //cell.backgroundColor = UIColor(hexString: "4A3878")?.darken(byPercentage: (CGFloat(indexPath.row) / CGFloat(feed.count)))
        cell.bookmarkImage.isHidden = checkBookmark(item: feed[indexPath.row].getMessage()) ? false : true
        cell.backgroundColor = .white
        cell.delegate = self
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //when clicking on a cell
        let safari = SFSafariViewController(url: URL(string: feed[indexPath.row].getLink())!)
        safari.modalPresentationStyle = .overFullScreen
        self.present(safari, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //when swiping on a cell
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let check = checkBookmark(item: feed[indexPath.row].getMessage())
        if check {
            let deleteAction = SwipeAction(style: .destructive, title: "Remove") { action, indexPath in
                // handle action by updating model with deletion
                self.deleteBookmarked(indexPath: indexPath)
                
                
            }
            // customize the action appearance
            deleteAction.backgroundColor = UIColor.red
            deleteAction.image = UIImage(named: "literature")
            deleteAction.textColor = .black
            return [deleteAction]
        }
        else{
            let bookmarkAction = SwipeAction(style: .default, title: "Bookmark") { action, indexPath in
                // handle action by updating model with deletion
                self.saveBookmark(feed: self.feed[indexPath.row])
                
            }
            // customize the action appearance
            bookmarkAction.backgroundColor = UIColor(hexString: "b7a57a")
            bookmarkAction.image = UIImage(named: "literature")
            bookmarkAction.textColor = .black
            return [bookmarkAction]
        }
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        //slide option
        var options = SwipeOptions()
        //options.expansionStyle = .selection
        options.transitionStyle = .reveal
        return options
    }
    
    
    func saveBookmark(feed: Feed){
        let check = checkBookmark(item: feed.getMessage())
        
        if check {
            print("duplicate")
        }
        else{
            print("new")
            do{
                
                //try context.save() //CoreData
                try realm.write {
                    
                    realm.add(Feed(message: feed.getMessage(), createdTime: feed.createdTime!, link: feed.getLink()))
                    let alert = UIAlertController(title: nil, message: "Added", preferredStyle: .alert)
                    present(alert,animated: true,completion: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }
            }
            catch{
                print("Save Error")
            }
        }
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        feedTable.reloadData()
    }
    func loadBookmarked(){
        bookmarkArray = realm.objects(Feed.self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! bookmarkTableViewController
        destination.bookmarkArray = bookmarkArray
    }
    
    func deleteBookmarked(indexPath: IndexPath) {
        
        let feedDelete = bookmarkArray?.filter("message == %@", feed[indexPath.row].getMessage()).first
        //let index = bookmarkArray?.index(of: feedDelete)
        if let delete = feedDelete{
            do{
                
                try self.realm.write {
                    self.realm.delete(delete) //delete at that row
                    let alert = UIAlertController(title: nil, message: "Removed", preferredStyle: .alert)
                    present(alert,animated: true,completion: {
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                    
                }
            } catch{
                print("Error updating")
            }
            tableView.reloadData()
        
        }
    }
    func checkBookmark(item: String) -> Bool{
        let check = bookmarkArray?.filter("message == %@", item)
        if (check?.count)! > 0 {
            return true
        }
        else{
            return false
        }
    }
}

extension feedTableViewController: UISearchBarDelegate{
    //Changes feed based on search bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count != 0{
            feedSearch = feed.filter({ return ($0.getMessage().lowercased().contains(searchBar.text!.lowercased()))})
            inSearch = true
            tableView.reloadData()
        }
        else {
            inSearch = false
            tableView.reloadData()
        }
    }
    
}
