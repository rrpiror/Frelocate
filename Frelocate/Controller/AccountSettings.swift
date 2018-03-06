//
//  Account.swift
//  Frelocate
//
//  Created by Rob Prior on 21/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation
import Firebase

class AccountSettings: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
     
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var profilePicture: UIImageView!
    
    var post: Post?
    var posts = [Post]()
    
    static var imageCache = NSCache<NSString, UIImage>()
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        let username = Auth.auth().currentUser?.email
        usernameLabel.text = "Welcome, " + username!
        
        
        
        
        DataService.ds.REF_POSTS.observe(.value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        return PostCell()

//        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
//
//            if let img = SearchProperties.imageCache.object(forKey: post.imageUrl as NSString) {
//                cell.configureCell(post: post, img: img)
//                return cell
//            } else {
//                cell.configureCell(post: post)
//                return cell
//            }
//        } else {
//            return PostCell()
//        }
    }
    
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Signing Out", message: "Are you sure?", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {
            (action) -> Void in
            KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            try! Auth.auth().signOut()
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
   
    
    
    
}
