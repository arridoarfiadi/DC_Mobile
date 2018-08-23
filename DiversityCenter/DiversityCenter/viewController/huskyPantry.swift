//
//  SecondViewController.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 4/20/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SVProgressHUD

class huskyPantry: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBAction func signout(_ sender: UIBarButtonItem) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        self.performSegue(withIdentifier: "signout", sender: self)
    }
    
    
    
    
    @IBOutlet weak var inventoryTable: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    var ref: DatabaseReference = Database.database().reference()
    var filteredData = [String]()
    var inSearchMode = false
    var itemName: [String] = []
    var count: [String]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inventoryTable.delegate = self
        inventoryTable.dataSource = self
        search.delegate = self
        search.barTintColor = UIColor(hexString: "4B2E83")
        getData()
        setRefresh()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            
            return filteredData.count
        }
        return itemName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = inventoryTable.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        if inSearchMode {
            
            cell?.textLabel?.text = filteredData[indexPath.row]
            cell?.detailTextLabel?.text = "\(count[itemName.index(of: filteredData[indexPath.row])!])"
            
        } else {
            
            cell?.textLabel?.text = itemName[indexPath.row]
            cell?.detailTextLabel?.text = "\(count[indexPath.row])"
        }
        
        
        
        return cell!
    }
    
    @objc func getData(){
        //retrieve from db
        navigationController?.navigationBar.prefersLargeTitles = false
        SVProgressHUD.show()
        let pantryDB = ref.child("DCPantry")
        pantryDB.observe(.childAdded) { (snapshot) in
            let name = snapshot.key
            let number = snapshot.value as! String
            self.itemName.append(name)
            self.count.append(number)
            
            self.inventoryTable.reloadData()
            self.inventoryTable.refreshControl?.endRefreshing()
            self.navigationController?.navigationBar.prefersLargeTitles = true
            SVProgressHUD.dismiss()
        }
        print(itemName)
        

    }
    func setRefresh(){
        let refresh = UIRefreshControl()
        refresh.tintColor = UIColor(hexString: "b7a57a")
        refresh.attributedTitle = NSAttributedString(string: "Refreshing Inventory")
        refresh.addTarget(self, action: #selector(getData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            inventoryTable.refreshControl = refresh
        } else {
            inventoryTable.addSubview(refresh)
        }
        
    }

}

extension huskyPantry:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            
            view.endEditing(true)
            
            inventoryTable.reloadData()
            
        } else {
            
            inSearchMode = true
            
            filteredData = itemName.filter({$0.contains(searchBar.text!)})
            
            inventoryTable.reloadData()
        }
    }
}





