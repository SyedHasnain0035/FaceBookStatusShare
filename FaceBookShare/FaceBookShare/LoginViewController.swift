//
//  LoginViewController.swift
//  FaceBookShare
//
//  Created by Rashdan Natiq on 24/08/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit
import  FacebookLogin
class LoginViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var accessToken: UILabel!
    @IBOutlet weak var permission: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goButtonClikced(_ sender: UIButton) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func loginWithFB(_ sender: Any) {
        
        let logManager = LoginManager()
     logManager.logIn([.publicProfile], viewController: self) { (result) in
        
        switch result {
        case .failed(let error):
            print(error.localizedDescription)
        case .cancelled:
            print("cancelled")
        case .success( let grantPermission, _, let userInfo):
            self.accessToken.text = userInfo.authenticationToken
            self.permission.text = grantPermission.map {"\($0)"}.joined(separator: "")
            
        }
        }
      
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
