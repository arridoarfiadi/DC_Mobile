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

class bookmarkTableViewController: UITableViewController {
    var feed : [Feed] = []
    var bookmarkArray: Results<Feed>?
    var feedSearch: [Feed] = []
    var inSearch: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "bookmarkCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "feedCell")
        print("hi")
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of rows
        if inSearch{
            return (bookmarkArray?.count)!
        }
        return (bookmarkArray?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Setting up each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCellTableViewCell
        if inSearch{
            cell.postFeed = feedSearch[indexPath.row]
        }
        else{
            print("test")
            cell.postFeed = bookmarkArray?[indexPath.row]
        }
        cell.backgroundColor = .white
        return cell
    }
    
}
