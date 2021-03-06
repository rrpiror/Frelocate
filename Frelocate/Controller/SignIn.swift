//
//  SignIn.swift
//  
//
//  Created by Rob Prior on 23/11/2017.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class SignIn: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard FIRAuth.auth()?.currentUser != nil else {
//            self.performSegue(withIdentifier: "signInComplete", sender: nil)
//            return
//        }
        
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

    @IBAction func facebookBtnTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("ROB: Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("ROB: User cancelled Facebook Authentication")
            } else {
                print("ROB: Successfully uthenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                self.performSegue(withIdentifier: "signInComplete", sender: nil)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("ROB: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("ROB: Succesfully authenticated with Firebase")
                }
            }
        )}
    
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pass = passwordField.text, (email.count > 0 && pass.count > 0) {
            AuthService.instance.signIn(email: email, password: pass, onComplete: { (errMsg, data) in
                guard errMsg == nil else {
                    let alert = UIAlertController(title: "Error signing up", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "signInComplete", sender: nil)
            })
        } else {
            let alert = UIAlertController(title: "Email and password required", message: "Please enter both a username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }
}

    


