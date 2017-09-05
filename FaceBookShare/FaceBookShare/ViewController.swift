//
//  ViewController.swift
//  FaceBookShare
//
//  Created by Rashdan Natiq on 24/08/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var myText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shareButtonClicked(_ sender: UIButton) {
        // Alert
        let alert = UIAlertController(title: "Share", message: "", preferredStyle: .actionSheet)
        // First Action
        let actionOne = UIAlertAction(title: "Share On Facebook", style: .default) { (action) in
            // checking if user is connected to facebook
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                // post initiate
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                // post text 
                post.setInitialText(self.myText.text)
                // post image
                post.add(#imageLiteral(resourceName: "pho"))
                // present Post
                self.present(post, animated: true, completion: nil)
            } else {
                self.showAlert(service: "Facebook")
            }
        }
        
        // Second Action
        let actionTwo = UIAlertAction(title: "Share On Twiter", style: .default) { (action) in
            // checking if user is connected to facebook
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                // post initiate
                let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                // post text
                post.setInitialText(self.myText.text)
                // post image
                post.add(#imageLiteral(resourceName: "pho"))
                // present Post
                self.present(post, animated: true, completion: nil)
            } else {
                self.showAlert(service: "Twiter")
            }
        }
        // Cancel Action
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // add Action
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        alert.addAction(actionCancel)
        
        self.present(alert, animated: true , completion: nil)
    }
    func showAlert(service: String) {
       let alert = UIAlertController(title: "Error", message: "You are Not Connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

