//
//  EstimateTimeTableViewCell.swift
//  CreamTesting
//
//  Created by Rashdan Natiq on 20/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit

class EstimateTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var eta: UILabel!
    @IBOutlet weak var display_name: UILabel!
    @IBOutlet weak var product_id: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
