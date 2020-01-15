//
//  ViewController.swift
//  MAD4114GPc0766628c0762152
//
//  Created by SanDEV on 2020-01-15.
//  Copyright © 2020 SanDEV. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categories:[NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      //1
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      let managedContext = appDelegate.persistentContainer.viewContext
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Categories")
      
      //3
      do {
        categories = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
    @IBAction func AddCategory(_ sender: UIBarButtonItem) {
        // Implement the addName IBAction
let alert = UIAlertController(title: "New Category Name",message: "Add a new category",preferredStyle: .alert)
let saveAction = UIAlertAction(title: "Save", style: .destructive)
{
        [unowned self] action in
        guard let textField = alert.textFields?.first,
          let nameToSave = textField.text else {
            return
        }
        self.save(name: nameToSave)
        self.tableView.reloadData()
      }
        let cancelAction = UIAlertAction(title: "Cancel",style: .cancel)
          alert.addTextField()
          alert.addAction(saveAction)
          alert.addAction(cancelAction)
        present(alert, animated: true)
        }
    func save(name: String)
    {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      // 2
      let entity = NSEntityDescription.entity(forEntityName:"Categories",in: managedContext)!
      
      let person = NSManagedObject(entity: entity,insertInto: managedContext)
      // 3
      person.setValue(name, forKeyPath: "name")
      // 4
      do {
        try managedContext.save()
        categories.append(person)
      }
      catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
}

// MARK: - UITableViewDataSource
extension CategoriesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath)-> UITableViewCell {
let category = categories[indexPath.row]
let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
    cell.textLabel?.text = category.value(forKeyPath: "name") as? String
    return cell
  }
}

