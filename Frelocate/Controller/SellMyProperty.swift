//
//  SellHome.swift
//  Frelocate
//
//  Created by Rob Prior on 20/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation
import Firebase



class SellMyProperty: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    
    var imageSelected = false
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var valueTextFiled: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var streetNameTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        emailTextField.text = FIRAuth.auth()?.currentUser?.email
        
        self.titleTextField.delegate = self
        self.valueTextFiled.delegate = self
        self.locationTextField.delegate = self
        self.descriptionTextView.delegate = self
        self.streetNameTextField.delegate = self
        self.emailTextField.delegate = self
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
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
        emailTextField.resignFirstResponder()

        return(true)
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
            imageSelected = true
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
    
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, title != "" else {
            createAlert(title: "No title entered", message: "You must enter a property title")
            print("ROB: Title not entered")
            return
        }
        guard let image = mainImage.image,imageSelected == true else {
            createAlert(title: "No photo selected", message: "You must select a main photo")
            print("ROB: An image must be selected")
            return
        }
        guard let value = valueTextFiled.text, value != "" else {
            createAlert(title: "No value entered", message: "You must enter a property value")
            print("ROB: Value not entered")
            return
        }
        guard let location = locationTextField.text, location != "" else {
            createAlert(title: "No location entered", message: "You must enter a property location")
            print("ROB: Location not entered")
            return
        }
        guard let street = streetNameTextField.text, street != "" else {
            createAlert(title: "No street name entered =", message: "You must enter a street name")
            print("ROB: Street name not entered")
            return
        }
        guard let detailedDescription = descriptionTextView.text, detailedDescription != "" else {
            createAlert(title: "No detailed description entered", message: "You must enter a detailed description")
            print("ROB: Detailed description not entered")
            return
        }
        guard let emailField = emailTextField.text, emailField != "" else {
            createAlert(title: "No email entered", message: "Please enter an email so potential buyers can contact you")
            print("ROB: Email textfield was not entered")
            return
        }
        
        
        if let imageData = UIImageJPEGRepresentation(image, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_MAIN_IMAGE.child(imgUid).put(imageData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    //add error
                    print("ROB: Unable to upload image to Firebase Storage")
                } else {
                    print("ROB: Successfully uploaded image to Firebase Storage")
                    let downloadUrl = metadata?.downloadURL()?.absoluteString
                    if let url = downloadUrl {
                      self.postToFirebase(imgUrl: url)
                    }
                    
                }
            }
        }
        
    }
    
    func postToFirebase(imgUrl: String) {
        let post: Dictionary<String, AnyObject> = [
            "title": titleTextField.text as AnyObject,
            "imageUrl": imgUrl as AnyObject,
            "location": locationTextField.text as AnyObject,
            "value": valueTextFiled.text as AnyObject,
            "street": streetNameTextField.text as AnyObject,
            "detailedDescription": descriptionTextView.text as AnyObject,
            "email": emailTextField.text as AnyObject
        ]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
    
        titleTextField.text = ""
        imageSelected = false
        mainImage.image = UIImage(named: "AddImage")
        
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }

}
