//
//  File.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 6/16/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import Foundation

class Feed {
    var json: [String : Any]
    var message: String?
    var id: String?
    init(json: [String:Any]){
        self.json = json
        self.message = json["message"] as? String
        self.id = json["id"] as? String
    }
}
