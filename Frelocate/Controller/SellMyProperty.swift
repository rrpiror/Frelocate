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
    
    @IBOutlet var getStartedLabel: UILabel!
    @IBOutlet var titleTextField: SearchTextField!
    @IBOutlet var valueTextFiled: UITextField!
    @IBOutlet var locationTextField: SearchTextField!
    @IBOutlet var streetNameTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        emailTextField.text = Auth.auth().currentUser?.email
        
        locationTextField.filterStrings(["Bath", "Birmingham", "Bradford", "Brighton and Hove", "Bristol", "Cambridge", "Canterbury", "Carlisle", "Chester", "Chichester", "Coventry", "Derby", "Durham", "Ely", "Exeter", "Gloucester", "Hereford", "Kingston upon Hull", "Lancaster", "Leeds", "Leicester", "Lichfield", "Lincoln", "Liverpool", "City of London", "Manchester", "Newcastle upon Tyne", "Norwich", "Nottingham", "Oxford", "Peterborough", "Plymouth", "Portsmouth", "Preston", "Ripon", "Salford", "Salisbury", "Sheffield", "Southampton", "St Albans", "Stoke-on-Trent", "Sunderland", "Truro", "Wakefield", "Wells", "Westminster", "Winchester", "Wolverhampton", "Worcester", "York"])
        
        titleTextField.filterStrings(["1 Bedroom Flat", "2 Bedroom Flat", "3 Bedroom Flat", "4 Bedroom Flat", "5 Bedroom Flat", "1 Bedroom House", "2 Bedroom House", "3 Bedroom House", "4 Bedroom House", "5 Bedroom House", "6 Bedroom House", "7 Bedroom House", "1 Bedroom Bungalow", "2 Bedroom Bungalow", "3 Bedroom Bungalow", "4 Bedroom Bungalow", "5 Bedroom Bungalow", "6 Bedroom Bungalow", "1 Bedroom Coach House", "2 Bedroom Coach House", "3 Bedroom Coach House", "4 Bedroom Coach House", "1 Bedroom Apartment", "2 Bedroom Apartment", "3 Bedroom Apartment", "4 Bedroom Apartment", "5 Bedroom Apartment", "1 Bedroom Mobile Home", "2 Bedroom Mobile Home", "3 Bedroom Mobile Home", "House", "Bungalow", "Mobile Home", "Boathouse", "Flat", "Apartment"])

        
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
            getStartedLabel.isHidden = true
            imageSelected = true
        }else {
            createAlert(title: "Valid image not selected", message: "Please select a valid image")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addMainImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
   
    
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, title != "" else {
            createAlert(title: "No title entered", message: "You must enter a property title")
            return
        }
        guard let image = mainImage.image,imageSelected == true else {
            createAlert(title: "No photo selected", message: "You must select a main photo")
            return
        }
        guard let value = valueTextFiled.text, value != "" else {
            createAlert(title: "No value entered", message: "You must enter a property value")
            return
        }
        guard let location = locationTextField.text, location != "" else {
            createAlert(title: "No location entered", message: "You must enter a property location")
            return
        }
        guard let street = streetNameTextField.text, street != "" else {
            createAlert(title: "No street name entered =", message: "You must enter a street name")
            return
        }
        guard let detailedDescription = descriptionTextView.text, detailedDescription != "" else {
            createAlert(title: "No detailed description entered", message: "You must enter a detailed description")
            return
        }
        guard let emailField = emailTextField.text, emailField != "" else {
            createAlert(title: "No email entered", message: "Please enter an email so potential buyers can contact you")
            return
        }
        
        
        if let imageData = UIImageJPEGRepresentation(image, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
           
            
            DataService.ds.REF_MAIN_IMAGE.child(imgUid).putData(imageData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    self.createAlert(title: "Something went wrong", message: "Please try again later, or contact us at Frelocate")
                } else {
                    self.createAlert(title: "Posted to Frelocate", message: "Thank you! Your property is now on Frelocate")
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
