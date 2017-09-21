//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Rashdan Natiq on 18/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit
import CoreData
class TableViewController: UITableViewController {
var listItem = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
            self.title = "The List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(TableViewController.addItem))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDalegate = UIApplication.shared.delegate as! AppDelegate
        let managedContax = appDalegate.persistentContainer.viewContext
       let fetchRequst = NSFetchRequest<NSFetchRequestResult>(entityName: "ListItem")
        do {
            let results = try managedContax.fetch(fetchRequst)
            listItem = results as! [NSManagedObject]
        } catch {
            print("Fetc error")
        }
    }
    // USER Define functions 
    func addItem()  {
        let alertController = UIAlertController(title: "Type", message: "Type..", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confrom ", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                self.saveItem(stringToSave: (field.text!))
                self.tableView.reloadData()
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField { (textField) in
            textField.placeholder = "Type in some thing"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func saveItem(stringToSave: String) {
        let appDalegate = UIApplication.shared.delegate as! AppDelegate
        let managedContax = appDalegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ListItem", in: managedContax)
        let item = NSManagedObject(entity: entity!, insertInto: managedContax)
        item.setValue(stringToSave, forKey: "item")
        do {
            try managedContax.save()
                listItem.append(item)
            } catch {
            print("Error")
            }
        }
    
    
    // TableView Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItem.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let item = listItem[indexPath.row]
        cell?.textLabel?.text = item.value(forKey: "item") as? String
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDalegate = UIApplication.shared.delegate as! AppDelegate
        let managedContax = appDalegate.persistentContainer.viewContext
        tableView.reloadRows(at: [indexPath], with: .right)
        managedContax.delete(listItem[indexPath.row])
        listItem.remove(at: indexPath.row)
        self.tableView.reloadData()
    }

}

