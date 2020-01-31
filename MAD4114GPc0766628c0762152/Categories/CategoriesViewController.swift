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
    //outlets
@IBOutlet weak var tableView: UITableView!
    //data storage
    var categories = [Categories]()
    
//    let dataFilePath
let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        
        guard (UIApplication.shared.delegate as? AppDelegate) != nil else {
          return
      }
        loadData()
    }
    
    func loadData(with request : NSFetchRequest<Categories> = Categories.fetchRequest())
    {
        do{
            categories = try managedContext.fetch(request)
            
        }catch
        {
            print("Could not fetch. \(error)")
        }
    }
    
    //Add categories
    @IBAction func AddCategory(_ sender: UIBarButtonItem) {
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
    //saving in core data
  func save(name: String)
    {
        guard (UIApplication.shared.delegate as? AppDelegate) != nil else {
        return
      }
    let entity = NSEntityDescription.entity(forEntityName:"Categories",in: managedContext)!
        
    let category = Categories(context: self.managedContext)
        category.name = name
        categories.append(category)
        
      do {
        try managedContext.save()
      }
      catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }    }
    
    
    
    //let the category delete
    @IBAction func EditCategories(_ sender: Any)
    {
        editButtonItem.title = editButtonItem.title == "Edit" ? "Done" : "Edit"
 tableView.setEditing(!tableView.isEditing, animated: true)
    }}

// MARK: - UITableViewDataSource
extension CategoriesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath)-> UITableViewCell {
let category = categories[indexPath.row]
let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
cell.selectionStyle = .none
cell.accessoryType = .disclosureIndicator
    cell.textLabel?.text = category.value(forKeyPath: "name") as? String
        return cell
  }
}
// MARK: - UITableViewDataDelegate
extension CategoriesViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(self.categories[indexPath.row])
            do{
                try managedContext.save()
                loadData()
                self.tableView.reloadData()
                }catch{
                print("Failed")
            }}}
    //edit button converting to done with these method
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    {
        self.editButtonItem.title = "Done"
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    {
        self.editButtonItem.title = "Edit"
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    func perform() {
        // Add your own animation code here.

    }
    func callSegueFromCell(myData dataobject: AnyObject) {
       //try not to send self, just to avoid retain cycles(depends on how you handle the code on the next controller)
       self.performSegue(withIdentifier: "cetgoryToNotes", sender:dataobject )
     }
override func prepare(for segue: UIStoryboardSegue,sender: Any?)
    {
        let destinationVC = segue.destination as! MainTableViewController
        if let indexpath = tableView.indexPathForSelectedRow{
            destinationVC.parentCategory = categories[indexpath.row]
        }

    }
}
