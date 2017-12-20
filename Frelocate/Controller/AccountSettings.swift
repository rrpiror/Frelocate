//
//  Account.swift
//  Frelocate
//
//  Created by Rob Prior on 21/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation
import FirebaseAuth

class AccountSettings: UIViewController {
    
    @IBOutlet var profilePicture: UIImageView!
    
    @IBOutlet var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderWidth = 3
        profilePicture.layer.borderColor = (UIColor.white).cgColor
        
        let username = FIRAuth.auth()?.currentUser?.email
        
        usernameLabel.text = username
        
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        if FIRAuth.auth()?.currentUser != nil {
            //there is a user
            do {
                try FIRAuth.auth()?.signOut()
            } catch {
                let alert = UIAlertController(title: "Error signing out", message: "Please try again later", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
}
