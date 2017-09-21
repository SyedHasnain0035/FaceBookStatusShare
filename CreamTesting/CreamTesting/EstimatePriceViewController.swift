//
//  EstimatePriceViewController.swift
//  CreamTesting
//
//  Created by Rashdan Natiq on 20/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit

class EstimatePriceViewController: UIViewController {

    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var currency_code: UILabel!
    @IBOutlet weak var estimate: UILabel!
    @IBOutlet weak var low_estimate: UILabel!
    @IBOutlet weak var high_estimate: UILabel!
    @IBOutlet weak var metric: UILabel!
    @IBOutlet weak var surge_model: UILabel!
    @IBOutlet weak var surge_multiplier: UILabel!
    @IBOutlet weak var expiry_in_minutes: UILabel!
    @IBOutlet weak var token: UILabel!
    var data: EstimatePrice? = nil
    let CAREEM_APP_URL = "careem://"
    override func viewDidLoad() {
        super.viewDidLoad()
        setValueInLabel() 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setValueInLabel()  {
        
        self.duration.text = "Duration: \((data?.duration)!)"
        self.distance.text = "Distance: \((data?.distance)!) - \((data?.metric)!)"
        self.currency_code.text = "currency_code: PKR"
        self.estimate.text = "estimate:\((data?.estimate)!)"
        let lowPkr = API.shared.currencyConverter(curency: (data?.currency_code)!, amount: (data?.low_estimate)!)
        self.low_estimate.text = "low_estimate:\(lowPkr) - PKR"
        if (data?.high_estimate) != nil {
            let higPkr = API.shared.currencyConverter(curency: (data?.currency_code)!, amount: (data?.high_estimate)!)
            self.high_estimate.text = "high_estimate:\(higPkr) - PKR"
        } else {
            self.high_estimate.text = "high_estimate:\((data?.high_estimate))"
        }
        
        self.metric.text = "metric:\((data?.metric)!)"
        self.surge_model.text = "surge_model:"
        self.surge_multiplier.text = "surge_multiplier\((data?.surge_model?.multiplier))"
        self.expiry_in_minutes.text = "expiry_in_minutes:\((data?.surge_model?.expiry_in_minutes))"
        self.token.text = "token:\((data?.surge_model?.token))"
    }
    @IBAction func didTapDeeplinkingButton(_ sender: UIButton) {
        let ourApplication = UIApplication.shared
        let URLEncodedText = CAREEM_APP_URL.addingPercentEscapes(using: String.Encoding.utf8)
        let ourURL = URL(string: URLEncodedText!)
        if isCareemInstalled() {
            ourApplication.openURL(ourURL!)
        } else {
            openAppStore()
        }
    }
    
    func isCareemInstalled() -> Bool {
    if UIApplication.shared.canOpenURL(NSURL(string: CAREEM_APP_URL)! as URL)
    {
    return true
    }
    return false
    }
    func openAppStore() {
        let customURL: String = "itms-apps://itunes.apple.com/app/id592978487"
        if UIApplication.shared.canOpenURL(URL(string: customURL)!) {
            UIApplication.shared.openURL(URL(string: customURL)!)
        }
    }

}
