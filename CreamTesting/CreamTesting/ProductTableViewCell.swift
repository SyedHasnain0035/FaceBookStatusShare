//
//  ProductTableViewCell.swift
//  CreamTesting
//
//  Created by Rashdan Natiq on 21/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var maximum_time_to_cancel_later: UILabel!
    @IBOutlet weak var maximum_time_to_cancel_now: UILabel!
    @IBOutlet weak var minimum_time_to_book: UILabel!
    @IBOutlet weak var distance_unit: UILabel!
    @IBOutlet weak var availibility_later: UILabel!
    @IBOutlet weak var availibility_now: UILabel!
    @IBOutlet weak var cancellation_fee_now: UILabel!
    @IBOutlet weak var cancellation_fee_later: UILabel!
    @IBOutlet weak var cost_per_hour: UILabel!
    @IBOutlet weak var minimum_later: UILabel!
    @IBOutlet weak var minimum_now: UILabel!
    @IBOutlet weak var currency_code: UILabel!
    @IBOutlet weak var cost_per_distance: UILabel!
    @IBOutlet weak var base_later: UILabel!
    @IBOutlet weak var base_now: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var price_details: UILabel!
    @IBOutlet weak var display_order: UILabel!
    @IBOutlet weak var display_name: UILabel!
    @IBOutlet weak var capacity: UILabel!
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
