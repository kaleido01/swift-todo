//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray=[Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem=Item()
        newItem.title="first one"
        
        itemArray.append(newItem)
        
//        itemArray=defaults.array(forKey: "TodoListArray") as? [String] ?? []
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text=item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add New TodoeyItem", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title=textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new item"
            textField=alertTextField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
    }
    
    
}



