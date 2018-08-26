//
//  Alert.swift
//  DiversityCenterAdmin
//
//  Created by Arrido Arfiadi on 8/25/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import Foundation
import UIKit

class Alert{
    let alert: UIAlertController
    let choiceArray: [String]
    var chosen: String = ""
    init(title: String, message: String, array: [String]) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        choiceArray = array
    }
    
    func showAlert(vc: UIViewController){
        for i in 0..<choiceArray.count{
            alert.addAction(UIAlertAction(title: choiceArray[i], style: .default, handler: { (alertAction) in
                print("test")
                self.chosen = self.choiceArray[i]
            }))
        }
        vc.present(alert, animated: true, completion: nil)
    }
    
    func getChosen() -> String {
        return chosen
    }
    
    

}
