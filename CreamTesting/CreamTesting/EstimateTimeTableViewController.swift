//
//  EstimateTimeTableViewController.swift
//  CreamTesting
//
//  Created by Rashdan Natiq on 20/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit

class EstimateTimeTableViewController: UITableViewController {
 var estimatTimes = [Time]()
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        estimatTimes = []
    }
    override func viewWillAppear(_ animated: Bool) {
        estimatTimes = API.shared.timeEstimate
         tableView.reloadData()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return estimatTimes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EstimateTimeTableViewCell

        cell.product_id.text  = "Product Id: \(estimatTimes[indexPath.row].product_id!)"
        cell.display_name.text  = "display_name: \(estimatTimes[indexPath.row].display_name!)"
        cell.eta.text  = "eta: \(estimatTimes[indexPath.row].eta!)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        API.shared.getEstimatePrice(start_latitude: API.shared.start_latitude, start_longitude: API.shared.start_longitude, end_latitude: API.shared.end_latitude, end_longitude: API.shared.end_longitude, product_id: estimatTimes[indexPath.row].product_id!, booking_type: "NOW", pickup_time: 0) { (data) in
            if data != nil {
                self.goToNextVC1(priceDetail: data!)
            }
        }

    }
    func goToNextVC1(priceDetail: EstimatePrice)  {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "EstimatePriceViewController") as! EstimatePriceViewController
        nextVC.data = priceDetail
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

  

}
