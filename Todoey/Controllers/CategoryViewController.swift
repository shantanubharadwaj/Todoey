//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Shantanu Dutta on 22/08/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
       loadCategories()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField: UITextField?
        let alert = UIAlertController(title: "Add new Category Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            if let text = textField?.text, !text.isEmpty {
                let categoryItem = Category(context: self.context)
                categoryItem.name = text
                self.categoryArray.append(categoryItem)
                self.saveCategories()
            }
        }
        
        alert.addTextField { (alerttextField) in
            alerttextField.placeholder = "Create new category"
            textField = alerttextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadCategories()  {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        } catch let error {
            print("Error fetching Category data from context : \(error)")
        }
        self.tableView.reloadData()
    }
    
    func saveCategories() {
        do {
            try context.save()
        } catch let error {
            print("Error saving Category context : \(error)")
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? TodoListViewController, let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
}

//MARK:= TableView delegate/datasource
extension CategoryViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoItems", sender: self)
    }
}
