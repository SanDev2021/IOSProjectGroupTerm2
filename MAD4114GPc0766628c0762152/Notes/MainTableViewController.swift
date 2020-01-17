//
//  MainTableViewController.swift
//  MAD4114GPc0766628c0762152
//
//  Created by SanDEV on 2020-01-17.
//  Copyright © 2020 SanDEV. All rights reserved.
//


import UIKit
import CoreData

class MainTableViewController: UITableViewController {

    var notes = [Note]()
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotes()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Load the notes from Core Data
    func loadNotes() {
        let fetchRequest:NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            notes = try context.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch {
            print("cannot fetch from database")
        }
    }
    
    // Functionality for delete button
    @objc func deletePressed(_ sender: UIButton){
        context.delete(notes[sender.tag])
        loadNotes()
    }
    
    // Functionality for edit button - bring you to the next screen
    @objc func editPressed(_ sender: UIButton){
        performSegue(withIdentifier: "editOrAdd", sender: notes[sender.tag])
    }
    
    // Functionality for adding notes - bring you to the next screen
    @IBAction func addPressed(_ sender: Any) {
         performSegue(withIdentifier: "editOrAdd", sender: nil)
    }
    
    // Functionality for moving to the next screen passing necessary information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editOrAdd"{
            if let destination = segue.destination as? ViewController {
                if let editing = sender as? Note {
                    destination.editNotes = editing
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    // Display the following information on tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        cell.setNote(note: notes[indexPath.row])
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deletePressed(_:)), for: .touchUpInside)
        
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editPressed(_:)), for: .touchUpInside)
        return cell
    }
}

