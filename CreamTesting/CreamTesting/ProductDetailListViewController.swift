//
//  ProductDetailListViewController.swift
//  CreamTesting
//
//  Created by Rashdan Natiq on 21/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit

class ProductDetailListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myProuct = [Product]()
    var myPriceDetail = [PriceDetail]()

    @IBOutlet weak var myTabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myProuct = API.shared.myProuct
        myPriceDetail = API.shared.priceDetail
        // Do any additional setup after loading the view.
        myTabelView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        API.shared.timeEstimate = []
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myProuct.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = Bundle.main.loadNibNamed("ProductTableViewCell", owner: self, options: nil)?.first as! ProductTableViewCell
        self.setValueOfCell(cell: cell, i: indexPath.row)
        return cell
    }
    func setValueOfCell(cell: ProductTableViewCell, i: Int)  {
        let imageView = cell.myImage.viewWithTag(1) as! UIImageView
        imageView.sd_setImage(with: URL(string: (myProuct[i].image)!))
        cell.display_order.text = "display_order:\(myProuct[i].display_order!)"
        cell.display_name.text = "display_name:\(myProuct[i].display_name!)"
        cell.capacity.text = "capacity:\(myProuct[i].capacity!)"
        cell.product_id.text = "display_order:\(myProuct[i].product_id!)"
        cell.availibility_later.text = "availibility_later:\(myProuct[i].availibility_later!)"
        cell.maximum_time_to_cancel_now.text = "maximum_time_to_cancel_now:\(myProuct[i].maximum_time_to_cancel_now!)"
        cell.maximum_time_to_cancel_later.text = "maximum_time_to_cancel_later:\(myProuct[i].maximum_time_to_cancel_later!)"
        cell.minimum_time_to_book.text = "minimum_time_to_book\(myProuct[i].minimum_time_to_book!)"
        cell.availibility_now.text = "availibility_now:\(myProuct[i].availibility_now!)"
        // Price detail
        //cell.cancellation_fee_now.text = "cancellation_fee_now:\(myProuct[i].price_details?.cancellation_fee_now!)"
        //cell.cancellation_fee_later.text = "cancellation_fee_later:\(myProuct[i].price_details?.cancellation_fee_later!)"
        cell.cancellation_fee_now.text = "cancellation_fee_now:\(myPriceDetail[i].cancellation_fee_now!)"
        cell.cancellation_fee_later.text = "cancellation_fee_later:\(myPriceDetail[i].cancellation_fee_later!)"
        let costPerhr = API.shared.currencyConverter(curency: myPriceDetail[i].currency_code!, amount: myPriceDetail[i].cost_per_hour!)
        cell.cost_per_hour.text = "cost_per_hour:\(costPerhr)"
        cell.minimum_later.text = "minimum_later:\(myPriceDetail[i].minimum_later!)"
        cell.minimum_now.text = "minimum_now:\(myPriceDetail[i].minimum_now!)"
        cell.currency_code.text = "currency_code:\(myPriceDetail[i].currency_code!)"
        cell.distance_unit.text = "distance_unit:\(myPriceDetail[i].distance_unit!)"
        cell.cost_per_distance.text = "cost_per_distance:\(myPriceDetail[i].cost_per_distance!)"
        cell.base_later.text = "base_later:\(myPriceDetail[i].base_later!)"
        cell.base_now.text = "base_now:\(myPriceDetail[i].base_now!)"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 520
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        API.shared.getEstimateArivelTime(lat: API.shared.start_latitude, long: API.shared.start_longitude, productId: myProuct[indexPath.row].product_id!) { (time) in
            if time.count > 0 {
                self.goToNextVC()
            }
            
        }
    }
    func goToNextVC()  {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "EstimateTimeTableViewController") as! EstimateTimeTableViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}
