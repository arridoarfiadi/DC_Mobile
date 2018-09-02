//
//  roomTableViewCell.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 9/1/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit

class roomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageBox: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var roomCapLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
