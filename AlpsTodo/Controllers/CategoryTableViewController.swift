//
//  CategoryTableViewController.swift
//  AlpsTodo
//
//  Created by ALPER UYANIK on 9/9/18.
//  Copyright © 2018 ALPER UYANIK. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>? //which is a collection of results

    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadItems()
    }
    
    //MARK: - Table View Data source methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
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
            
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    //MARK: - Data Manupulation Methods
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
            
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
       categories = realm.objects(Category.self)  // fetching

        tableView.reloadData()
    }
    
    
    //MARK: - Add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what will happen when the user clics the Add item add button on our UIAlert
            
            let newCategory = Category()
            newCategory.name = textField.text!
           
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
