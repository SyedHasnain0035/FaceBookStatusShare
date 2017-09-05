//
//  ViewController.swift
//  NotificationExample
//
//  Created by Rashdan Natiq on 05/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAlow, error) in
            
        }
        UNUserNotificationCenter.current().delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func notificationSend(_ sender: UIButton) {
        notificationFunction()
    }
    func notificationFunction()  {
        
        let answer1 = UNNotificationAction(identifier: "answer1", title: "365", options: UNNotificationActionOptions.foreground)
        let answer2 = UNNotificationAction(identifier: "answer2", title: "345", options: UNNotificationActionOptions.foreground)
        
        let category = UNNotificationCategory(identifier: "myCategory", actions: [answer1, answer2], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        // set Notification Body
        let content = UNMutableNotificationContent()
        content.title = "How may Days in one Year"
        content.subtitle = "Do You Know"
        content.body = "Do You Really Know"
        content.categoryIdentifier = "myCategory"
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requst = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(requst, withCompletionHandler: nil)
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "answer1" {
            self.answerLabel.text = "Correct Answer"
        } else {
            self.answerLabel.text = "Wrong Answer"
        }
        completionHandler()
    }
}

