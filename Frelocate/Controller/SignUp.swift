//
//  SignUpViewController.swift
//  
//
//  Created by Rob Prior on 29/11/2017.
//

import UIKit
import Firebase

class SignUp: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var numbersLabel: UILabel!
    @IBOutlet var numbersTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomNumber()
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
        
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return (true)
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        if let email = emailField.text, let pass = passwordField.text, (email.count > 0 && pass.count > 0) {
            if numbersLabel.text == numbersTextField.text {
            
            AuthService.instance.signUp(email: email, password: pass, onComplete: { (errMsg, data) in
                guard errMsg == nil else {
                    let alert = UIAlertController(title: "Error signing up", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.performSegue(withIdentifier: "signUpComplete", sender: nil)
                //self.dismiss(animated: true, completion: nil)
                
            })
                
            } else {
                
                let alert = UIAlertController(title: "Invalid Verification", message: "Please enter the correct verification numbers to confirm you are not a robot", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.randomNumber()
                
            }
                
            } else {
            
            
            let alert = UIAlertController(title: "Email and password required", message: "Please enter both a username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        }
    
    func randomNumber() {
        let randomNumber = arc4random_uniform(1001) + 1000
        numbersLabel.text = String(randomNumber)
    }

    }

