//
//  UserViewController.swift
//  CoreDataExample
//
//  Created by Rashdan Natiq on 19/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit
import CoreData
class UserViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confromPasswordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var singUpView: UIView!
    
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginUserName: UITextField!
    @IBOutlet weak var loginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.isHidden = true
        
    }
    func saveUserInfo(_ userName: String, _ password: String) -> Bool {
        let appDeligate = UIApplication.shared.delegate as! AppDelegate
        let manageContaxt = appDeligate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: manageContaxt)
        newUser.setValue(userName, forKey: "name")
        newUser.setValue(password, forKey: "password")
        
        do {
            try manageContaxt.save()
            return true
        } catch {
            print("Save Error")
            return false
        }
    }
    func fetchUserInfo(_ userName: String, _ password: String) -> Bool {
        let appDeligate = UIApplication.shared.delegate as! AppDelegate
        let manageContaxt = appDeligate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let results = try manageContaxt.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    let user = result.value(forKey: "name") as! String
                    let pass =  result.value(forKey: "password") as! String
                    
                    if user == userName && pass == password {
                        return true
                    }
                }
                
            }
            
        } catch {
            return false
        }
        
        return false
    }
    @IBAction func didTapRegisteredButton(_ sender: UIButton) {
        if userNameTextField.text! == "" || passwordTextField.text! == "" || confromPasswordTextField.text! == "" {
            print("Pleae fill complete information")
        } else {
            if passwordTextField.text == confromPasswordTextField.text {
                let save = self.saveUserInfo(userNameTextField.text!, passwordTextField.text!)
                if save == true {
                    print("Save Succesfully")
                    let nextVC = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }else {
                    print("Error")
                }
                
            } else {
                print("Password Not Matchedd")
            }
        }
    }
    
    @IBAction func loginUserButtonClicked(_ sender: UIButton) {
        if loginUserName.text! == "" || loginPassword.text! == "" {
            
        } else {
            let login = fetchUserInfo(loginUserName.text!, loginPassword.text!)
            if login == true {
                print("Succesfuuly Login")
                let nextVC = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                print(" Login Error")
            }
        }
    }
    @IBAction func singUpoption(_ sender: UIButton) {
        singUpView.isHidden = false
        loginView.isHidden = true
    }
    
    @IBAction func loginOption(_ sender: UIButton) {
        singUpView.isHidden = true
        loginView.isHidden = false
    }
    
}
