//
//  bookmarkTableViewController.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 8/18/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import RealmSwift
import SwipeCellKit
import SafariServices

class bookmarkTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    var bookmarkArray: Results<Feed>?
    let realm = try! Realm()
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let nib = UINib(nibName: "bookmarkCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "feedCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of rows
        return (bookmarkArray?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Setting up each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCellTableViewCell
        cell.postFeed = bookmarkArray?[indexPath.row]
        cell.backgroundColor = .white
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
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
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        //slide option
        var options = SwipeOptions()
        //options.expansionStyle = .selection
        options.transitionStyle = .reveal
        return options
    }
    
    func loadBookmarked(){
        bookmarkArray = realm.objects(Feed.self)
        
    }
    
    func deleteBookmarked(indexPath: IndexPath) {
        
        let feedDelete = bookmarkArray?[indexPath.row]
        //let index = bookmarkArray?.index(of: feedDelete)
        if let delete = feedDelete{
            do{
                
                try self.realm.write {
                    self.realm.delete(delete) //delete at that row
                    
                    //alert
                    let alert = UIAlertController(title: nil, message: "Removed", preferredStyle: .alert)
                    present(alert,animated: true,completion: {
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                }
            } catch{
                print("Error updating")
            }
            
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //when clicking on a cell
        let safari = SFSafariViewController(url: URL(string: bookmarkArray![indexPath.row].getLink())!)
        safari.modalPresentationStyle = .overFullScreen
        self.present(safari, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

extension bookmarkTableViewController: UISearchBarDelegate{
    //Changes feed based on search bar
    //let check = bookmarkArray?.filter("message == %@", item)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            //reload when cancelled
            loadBookmarked()
            tableView.reloadData()
        }
        else {
            //filters
            if bookmarkArray?.count == 0 {
                loadBookmarked()
            }
            bookmarkArray = bookmarkArray?.filter("message CONTAINS[cd] %@", searchBar.text!.lowercased())
            tableView.reloadData()
        }
    }
    
}
