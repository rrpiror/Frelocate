//
//  AuthService.swift
//  Frelocate
//
//  Created by Rob Prior on 03/12/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func signUp(email: String, password: String, onComplete: @escaping Completion) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.handleFirebaseErrors(error: error! as NSError, onComplete: onComplete)
            } else {
                if user?.uid != nil {
                    //sign in
                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            self.handleFirebaseErrors(error: error! as NSError, onComplete: onComplete)
                        } else {
                            onComplete(nil, user)
                            let userData = ["provider": user?.providerID]
                            self.completeSignIn(id: (user?.uid)!, userData: userData as! Dictionary<String, String>)
                        }
                    })
                }
            }
        })
    }
    
    func signIn(email: String, password: String, onComplete: @escaping Completion) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.handleFirebaseErrors(error: error! as NSError, onComplete: onComplete)
            } else {
                onComplete(nil, user)
                let userData = ["provider": user?.providerID]
                self.completeSignIn(id: (user?.uid)!, userData: userData as! Dictionary<String, String>)
            }
        })
        
    }
    
    func handleFirebaseErrors(error:NSError, onComplete: @escaping Completion) {
        print(error.debugDescription)
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            switch (errorCode) {
            case .errorCodeEmailAlreadyInUse:
                onComplete("There is already an account with that email address", nil)
                break
            case .errorCodeInvalidEmail:
                onComplete("Invalid email address", nil)
                break
            case .errorCodeWrongPassword:
                onComplete("Incorrect password", nil)
                break
            case .errorCodeAccountExistsWithDifferentCredential:
                onComplete("Account credentials already exist", nil)
            case .errorCodeWeakPassword:
                onComplete("Password used is too weak, please enter a different password", nil)
            case .errorCodeUserDisabled:
                onComplete("User has been disabled, please contact Frelocate", nil)
            default:
                onComplete("There was a problem signing up. Please try again later", nil)
            }
        }
        
        
        
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ROB: Data saved to keychain \(keychainResult)")
    }
    
}

