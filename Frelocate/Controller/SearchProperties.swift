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
    
    override func viewDidLoad() {
    
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
}
