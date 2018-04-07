//
//  MyTableViewCell.swift
//  CalculateAgent
//
//  Created by Dongze Li on 4/5/18.
//  Copyright © 2018 Dongze Li. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var hospitalLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var numOfDeliveryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
