//
//  File.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 6/16/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import Foundation

class Feed {
    let tempLink: String = "https://www.facebook.com/diversitycenteruwb/"
    var message: String?
    var createdTime: String?
    var description: String?
    var link: String?
    init(singleFeed: [String:Any]){
        self.message = singleFeed["message"] as? String
        self.createdTime = singleFeed["created_time"] as? String
        self.description = singleFeed["description"] as? String
        self.link = singleFeed["link"] as? String

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
        if self.message != nil && self.description != nil{
            return (self.message! + "\n" + self.description!)
        }
        else if self.message == nil && self.description != nil{
            return("Diversity Center shared a post \n" + self.description!)
            
        }
        else if self.message != nil && self.description == nil {
            return self.message!
        }
        else{
            return("NOT")
        }
    }
    func getDescription()-> String{
        if self.description != nil{
            return self.description!
        }
        else{
            return(" ")
        }
    }
    
    func getLink()-> String{
        if let test = self.link{
            
            return self.link!
            
        }
        else{
            
            return tempLink
        }
        
        
    }
}
