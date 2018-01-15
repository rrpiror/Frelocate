//
//  SellHome.swift
//  Frelocate
//
//  Created by Rob Prior on 20/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation



class SellMyProperty: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var valueTextFiled: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var streetNameTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var mainImage: UIImageView!
    
    
    override func viewDidLoad() {
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.titleTextField.delegate = self
        self.valueTextFiled.delegate = self
        self.locationTextField.delegate = self
        self.descriptionTextView.delegate = self
        self.streetNameTextField.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        textViewEditable()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        valueTextFiled.resignFirstResponder()
        locationTextField.resignFirstResponder()
        streetNameTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
        
        return (true)
    }
    
    func textViewEditable() {
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.cornerRadius = 5
        
        descriptionTextView.isEditable = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            mainImage.image = image
        }else {
            print("ROB: A valid image wasnt selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addMainImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addPhoto1Pressed(_ sender: Any) {
    }
    
    @IBAction func addPhoto2Pressed(_ sender: Any) {
    }
    
    @IBAction func addPhoto3Pressed(_ sender: Any) {
    }
    
    @IBAction func addPhoto4Pressed(_ sender: Any) {
    }
    
    @IBAction func addPhoto5Pressed(_ sender: Any) {
    }
    
    @IBAction func addPhoto6Pressed(_ sender: Any) {
    }
    
    @IBAction func addPhoto7Pressed(_ sender: Any) {
    }
    
    @IBAction func addPhoto8Pressed(_ sender: Any) {
    }
    
    @IBAction func addPhoto9Pressed(_ sender: Any) {
    }
    
    @IBAction func addPhoto10Pressed(_ sender: Any) {
    }
    
}
