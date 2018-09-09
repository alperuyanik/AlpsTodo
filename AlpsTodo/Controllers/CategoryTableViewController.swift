//
//  CategoryTableViewController.swift
//  AlpsTodo
//
//  Created by ALPER UYANIK on 9/9/18.
//  Copyright © 2018 ALPER UYANIK. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categories = [Category]()

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadItems()
    }
    
    //MARK: - Table View Data source methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categories[indexPath.row]
        
        cell.textLabel?.text = item.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    //tablelView üstündeki bir satıra tıklayınca ne olacağını buraya yazarız
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    //this will be triggired just before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        //grap the category that corresponds the selected cell so I need to know that what is the selected cell
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
    //MARK: - Data Manupulation Methods
    
    func saveItem() {
        
        do {
            try context.save()
            
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        // let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data form context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what will happen when the user clics the Add item add button on our UIAlert
            
            let newItem = Category(context: self.context)
            newItem.name = textField.text!
           
            self.categories.append(newItem)
            
            self.saveItem()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Table View Data source methods
    
    
    //MARK: - TableView Delegete methods
    
    
    //MARK: - Data Manupulation Methods
    
}
