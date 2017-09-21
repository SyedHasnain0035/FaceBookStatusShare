//
//  API.swift
//  CreamTesting
//
//  Created by Rashdan Natiq on 19/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class  API {
    var myProuct = [Product]()
    var priceDetail = [PriceDetail]()
    var timeEstimate = [Time]()
    var start_latitude = 0.0
    var start_longitude = 0.0
    var end_latitude = 31.7123092 //31.475
    var end_longitude = 73.9833491 //74.308
    static let shared = API()
    static let baseURLPath = "https://interface.careem.com"
    static let production = "/v1/products"
    static let estimateTime = "/v1/estimates/time"
    static let estimatePrice = "/v1/estimates/price"
    static let authenticationToken = "test-gop3uhggli20aeol8n13h1p4hb"
    // First API
    func getProductsInfo(lat: Double,long: Double, completion: @escaping ([Product]) -> Void) {
        Alamofire.request(
            "\(API.baseURLPath)\(API.production)?",
            parameters: ["latitude": lat, "longitude": long],
            headers: ["Authorization": API.authenticationToken]
            )
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(response.result.error)")
                    completion([Product]())
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    completion([Product]())
                    return
                }
                print(responseJSON)
                let myJson = JSON(responseJSON)
                let productDetail = myJson["products"]
                for i in 0 ..< productDetail.count{
                    let pro = myJson["products"][i]
                    let result = Product(json: pro)
                    self.myProuct.append(result)
                    let priceDetail = PriceDetail(json: pro["price_details"])
                    self.priceDetail.append(priceDetail)
                    if i == productDetail.count - 1 {
                        completion(self.myProuct)
                    }
                }
                
        }
    }
   // second API
    func getEstimateArivelTime(lat: Double,long: Double,productId: Int, completion: @escaping ([Time]) -> Void) {
        Alamofire.request(
            "\(API.baseURLPath)\(API.estimateTime)?",
            parameters: ["start_latitude": lat, "start_longitude": long, "product_id": productId],
            headers: ["Authorization": API.authenticationToken]
            )
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(response.result.error)")
                    completion([Time]())
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    completion([Time]())
                    return
                }
                print(responseJSON)
                let myJson = JSON(responseJSON)
                let timeEstimat = myJson["times"]
                for i in 0 ..< timeEstimat.count{
                    let timeEs = myJson["times"][i]
                    let resultTime = Time(json: timeEs)
                    self.timeEstimate.append(resultTime)
                    if i == timeEstimat.count - 1 {
                        completion(self.timeEstimate)
                    }
                    
                }
                
        }
    }
    // Third API
    func getEstimatePrice(start_latitude: Double,start_longitude: Double,end_latitude: Double,end_longitude: Double,product_id: Int, booking_type: String, pickup_time: Int?, completion: @escaping (EstimatePrice?) -> Void) {
        Alamofire.request(
            "\(API.baseURLPath)\(API.estimatePrice)?",
            parameters: ["start_latitude": start_latitude, "start_longitude": start_longitude,"end_latitude": end_latitude, "end_longitude": end_longitude, "product_id": product_id, "pickup_time": pickup_time ?? 0],
            headers: ["Authorization": API.authenticationToken]
            )
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(response.result.error)")
                    completion(nil)
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    completion(nil)
                    return
                }
                print(responseJSON)
                let myJson = JSON(responseJSON)
                print(myJson)
                let resultPrice = EstimatePrice(json: myJson)
                completion(resultPrice)
                
        }
        
    }
    func currencyConverter(curency: String, amount: Double) -> Double {
        switch curency {
        case "AUD":
            let pkr = amount * 83.5
            return pkr
        case "AED" :
            let pkr = amount * 28.65
            return pkr
        default:
            return amount
        }
    }

}

// end of API class
class Product {
    var product_id : Int?
    var capacity : Int?
    var display_name: 	String?
    var display_order:	Int?
    var price_details:	PriceDetail?
    var availibility_now :	Bool?
    var availibility_later :	Bool?
    var image :	String?
    var minimum_time_to_book :	Int?
    var maximum_time_to_cancel_now :	Int?
    var maximum_time_to_cancel_later :	Int?
    init(json: JSON){
        self.product_id = json["product_id"].int
        self.capacity = json["capacity"].int
        self.display_name = json["display_name"].string
        self.display_order = json["display_order"].int
        self.price_details =  PriceDetail(json: json["price_details"])
        self.availibility_now = json["availibility_now"].bool
        self.availibility_later = json["availibility_later"].bool
        self.minimum_time_to_book = json["minimum_time_to_book"].int
        self.image = json["image"].string
        self.maximum_time_to_cancel_now = json["maximum_time_to_cancel_now"].int
        self.maximum_time_to_cancel_later = json["maximum_time_to_cancel_later"].int
    }
}
class PriceDetail: NSObject {
    var base_now : Double?
    var base_later: Double?
    var cost_per_distance:Double?
    var distance_unit:String?
    var currency_code:String?
    var  minimum_now:Double?
    var minimum_later:Double?
    var cost_per_hour:Double?
    var cancellation_fee_later:Double?
    var cancellation_fee_now:Double?
    init(json: JSON) {
        self.base_now = json["base_now"].double
        self.base_later = json["base_later"].double
        self.cost_per_distance = json["cost_per_distance"].double
        self.distance_unit = json["distance_unit"].string
        self.currency_code = json["currency_code"].string
        self.minimum_now = json["minimum_now"].double
        self.minimum_later = json["minimum_later"].double
        self.cost_per_hour = json["cost_per_hour"].double
        self.cancellation_fee_later = json["cancellation_fee_later"].double
        self.cancellation_fee_now = json["cancellation_fee_now"].double
    }
}
class  Time : NSObject {
    var product_id: Int?
    var display_name: String?
    var eta: Int?
    init(json: JSON) {
        self.product_id = json["product_id"].int
        self.display_name = json["display_name"].string
        self.eta = json["eta"].int
    }
}
class  EstimatePrice : NSObject {
    var duration: Int?
    var estimate: String?
    var distance: Double?
    var low_estimate: Double?
    var high_estimate: Double?
    var metric: String?
    var currency_code: String?
    var surge_model: Surge?
    init(json: JSON) {
        self.duration = json["duration"].int
        self.estimate = json["estimate"].string
        self.distance = json["distance"].double
        self.low_estimate = json["low_estimate"].double
        self.high_estimate = json["high_estimate"].double
        self.surge_model = Surge(json: json["surge"])
        self.metric = json["metric"].string
        self.currency_code = json["currency_code"].string
    }
}
class Surge: NSObject {
    var expiry_in_minutes: Int?
    var token: String?
    var multiplier: Double?
    init(json: JSON) {
        self.expiry_in_minutes = json["expiry_in_minutes"].int
        self.token = json["token"].string
        self.multiplier = json["multiplier"].double
    }
}
