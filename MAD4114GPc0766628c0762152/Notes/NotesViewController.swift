//
//  ViewController.swift
//  MAD4114GPc0766628c0762152
//
//  Created by SanDEV on 2020-01-17.
//  Copyright © 2020 SanDEV. All rights reserved.
//
import UIKit
var imagePicker: UIImagePickerController!

class NotesViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
@IBOutlet weak var titleText: UITextField!
      @IBOutlet weak var descriptionText: UITextView!
    var editNotes: Note?
var parentCategory : Categories?
    @IBOutlet weak var NoteImage: UIImageView!
    override func viewDidLoad() {
          super.viewDidLoad()
    if let note = editNotes {
              titleText.text = note.title
              //descriptionText.text = note.details
          }
      }
//MARK:-Saving notes
    @IBAction func saveNote(_ sender: Any) {
         var new: Note?
          if let note = editNotes {
              new = note
          } else {
            new = Note(context: context)
            new?.parentCategory = self.parentCategory
        }
           new?.title = titleText.text
          new?.details = descriptionText.text
          new?.date = NSDate() as Date
       
do {
              ad.saveContext()
              self.dismiss(animated: true, completion: nil)
            let alertBox = UIAlertController(title: "Note Saved!", message: "Save Successful.", preferredStyle: .alert)

            alertBox.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

            self.present(alertBox, animated: true, completion: nil)
          } catch {
            let alertBox = UIAlertController(title: "Error", message: "Error while saving.", preferredStyle: .alert)
            alertBox.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertBox, animated: true, completion: nil)
              print("cannot save")
        }}
    //MARK:-displaying action sheet with bottom camera button
    @IBAction func displayActionSheet(_ sender: Any) {
         // 1
        let actionSheet = UIAlertController(title: "Note Photo", message: "Choose Option to Add Picture", preferredStyle: .actionSheet)
        let PhotoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.PhotoLibrary()
        })
        let CameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
                   self.Camera()
               })
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(PhotoLibraryAction)
        actionSheet.addAction(CameraAction)
        actionSheet.addAction(cancelAction)
      self.present(actionSheet, animated: true, completion: nil)
    }
    func PhotoLibrary() {
    imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
    present(imagePicker, animated: true, completion: nil)
    }
        func Camera() {
        imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        NoteImage.image = info[.originalImage] as? UIImage
    }
}
