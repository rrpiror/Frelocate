//
//  ForgottenPassword.swift
//  Frelocate
//
//  Created by Rob Prior on 23/12/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation
import Firebase

class ForgottenPassword: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        return (true)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if emailField.text == nil {
            let alert = UIAlertController(title: "Email required", message: "Please enter your email address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            FIRAuth.auth()?.sendPasswordReset(withEmail: emailField.text!, completion: { (error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error submitting", message: "Please try again later", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "backToSignUp", sender: nil)
                }
            })
        }
        
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "backToSignUp", sender: nil)
    }
    
    
}
