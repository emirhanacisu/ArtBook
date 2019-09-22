//
//  DetailsVC.swift
//  artBook
//
//  Created by Erhan Acisu on 22.09.2019.
//  Copyright © 2019 Emirhan Acisu. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        //Recognizers
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
        
        let imageTabGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTabGesture)
        
        
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
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
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    


}
