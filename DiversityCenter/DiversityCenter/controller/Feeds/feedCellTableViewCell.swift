//
//  feedCellTableViewCell.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 6/16/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import SwipeCellKit

class feedCellTableViewCell: SwipeTableViewCell {



    var link: String!
    
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var bookmarkImage: UIImageView!
    var postFeed: Feed!{
        didSet{
            self.message.text = postFeed.getMessage()
            self.date.text = postFeed.getTime()
            self.link = postFeed.getLink()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
