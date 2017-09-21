//
//  ViewController.swift
//  CreamTesting
//
//  Created by Rashdan Natiq on 19/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var latitude = 0.0
    var longtitude = 0.0
    var prduct = [String]()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        API.shared.priceDetail = []
        API.shared.myProuct = []
        API.shared.timeEstimate = []
        determineMyCurrentLocation()
    }
    
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        self.longtitude = userLocation.coordinate.longitude
        self.latitude = userLocation.coordinate.latitude
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        

         manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    @IBAction func didTapCurrentLocation(_ sender: UIButton) {
        API.shared.start_latitude = self.latitude
        API.shared.start_longitude = self.longtitude
            API.shared.getProductsInfo(lat: self.latitude, long: self.longtitude, completion: { (succes) in
                print(succes.count)
                print(succes)
                self.gotoNextVc()
                
            })
           /* API.shared.getProducts(lat: self.latitude, long: self.longtitude, completion: { (obj) in
                if obj != nil {
                    
                }
            })*/
       
    }
    func getProduct()  {
        Alamofire.request(API.baseURLPath).response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
    }
    func gotoNextVc()  {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "ProductDetailListViewController") as! ProductDetailListViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

