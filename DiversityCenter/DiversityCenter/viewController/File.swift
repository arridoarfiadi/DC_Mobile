//
//  File.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 5/30/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import Foundation
import SQLite3


func openDatabase() -> OpaquePointer? {
    let part1DbPath = "/Users/arridoarfiadi/huskypantry.db"
    var db: OpaquePointer? = nil
    if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
        print("Successfully opened connection to database at \(part1DbPath)")
        return db
    } else {
        print("Unable to open database. Verify that you created the directory described " +
            "in the Getting Started section.")
    }
    return db
}


