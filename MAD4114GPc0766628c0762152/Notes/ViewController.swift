//
//  ViewController.swift
//  MAD4114GPc0766628c0762152
//
//  Created by SanDEV on 2020-01-17.
//  Copyright © 2020 SanDEV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


      @IBOutlet weak var titleText: UITextField!
      @IBOutlet weak var descriptionText: UITextView!
      var editNotes: Note?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          if let note = editNotes {
              titleText.text = note.title
              descriptionText.text = note.details
          }
      }
      
      @IBAction func dismiss(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
      }
      
      @IBAction func saveNote(_ sender: Any) {
          var new: Note?
          
          if let note = editNotes {
              new = note
          } else {
          new = Note(context: context)
          }
          new?.title = titleText.text
          new?.details = descriptionText.text
          new?.date = NSDate() as Date
          
          do {
              ad.saveContext()
              self.dismiss(animated: true, completion: nil)
          } catch {
              print("cannot save")
          }
      }
  }
