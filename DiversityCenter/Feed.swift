//
//  File.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 6/16/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import Foundation
import RealmSwift

class Feed: Object {
    let tempLink: String = "https://www.facebook.com/diversitycenteruwb/"
    @objc dynamic var message: String?
    @objc dynamic var createdTime: String?
    @objc dynamic var descriptionFeed: String?
    @objc dynamic var link: String?

    convenience init(singleFeed: [String:Any]){
        self.init()
        self.message = singleFeed["message"] as? String
        self.createdTime = singleFeed["created_time"] as? String
        self.descriptionFeed = singleFeed["description"] as? String
        self.link = singleFeed["link"] as? String

    }
    convenience init(message: String, createdTime: String, link: String) {
        self.init()
        self.message = message
        self.createdTime = createdTime
        self.link = link
    }

    
    func getTime() -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let datePrint = DateFormatter()
        datePrint.dateFormat = "dd MMMM yyyy"
        let date = dateFormat.date(from: self.createdTime!)
        return datePrint.string(from: date!)
    }
    
    func getMessage() -> String{
        if self.message != nil && self.descriptionFeed != nil{
            return (self.message! + "\n" + self.descriptionFeed!)
        }
        else if self.message == nil && self.descriptionFeed != nil{
            return("Diversity Center shared a post \n" + self.descriptionFeed!)
            
        }
        else if self.message != nil && self.descriptionFeed == nil {
            return self.message!
        }
        else{
            return("NOT")
        }
    }
//    func getDescription()-> String{
//        if let descriptionMessage = self.description{
//            return descriptionMessage
//        }
//        else{
//            return(" ")
//        }
//    }
    
    func getLink()-> String{
        if let test = self.link{
            
            return test
            
        }
        else{
            
            return tempLink
        }
        
        
    }
}
