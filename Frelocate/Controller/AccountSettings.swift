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
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var profilePicture: UIImageView!
    
    
    override func viewDidLoad() {
        
        roundProfilePicture()

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        let username = FIRAuth.auth()?.currentUser?.email
        usernameLabel.text = "Welcome, " + username!
        
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Signing Out", message: "Are you sure?", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {
            (action) -> Void in
            KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            try! FIRAuth.auth()?.signOut()
            self.performSegue(withIdentifier: "signOut", sender: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("ROB: User cancelled sign out")

        })
        alert.addAction(yesAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
        
    }
    
    func roundProfilePicture() {
        profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
    }
    
}
