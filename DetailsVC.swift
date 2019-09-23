//
//  DetailsVC.swift
//  artBook
//
//  Created by Erhan Acisu on 22.09.2019.
//  Copyright © 2019 Emirhan Acisu. All rights reserved.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Art Book"
        if chosenPainting != ""{
            //CoreData
            saveButton.isHidden = true
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
               let results = try  context.fetch(fetchRequest)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject]{
                       if let  name = result.value(forKey: "name") as? String {
                                
                       text1.text = name
                        }
                     if let artist = result.value(forKey: "artist") as? String{
                        text2.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int{
                            text3.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data{
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                                  
                                 
                                  }
                }
            }
            catch{
                
            }
           
            
        }
        else {
            saveButton.isHidden = false
            saveButton.isEnabled = false
        }
        
        
        
        
        
        //Recognizers
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
        
        let imageTabGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTabGesture)
        
        
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        

        //Attributes
        newPainting.setValue(text1.text!, forKey: "name")
        newPainting.setValue(text2.text!, forKey: "artist")
        
        if let year = Int(text3.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        NotificationCenter.default.post(name: Notification.Name("NewData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    @objc func selectImage(){
        let picker =  UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    


}
