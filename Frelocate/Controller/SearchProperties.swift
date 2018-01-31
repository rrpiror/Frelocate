//
//  SearchHomes.swift
//  Frelocate
//locate
//  Created by Rob Prior on 20/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation
import Firebase

class SearchProperties: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var post: Post!
    
    var posts = [Post]()
    static var imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
    
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
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
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            if let img = SearchProperties.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
        } else {
            return PostCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "propertyAdvert" {
            let destination = segue.destination as! propertyAdvert
            if let indexPath = self.tableView.indexPathForSelectedRow {
                destination.post = self.posts[indexPath.row]
            }
        }
    }
    
    
   
    
    
}
