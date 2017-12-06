//
//  BackTableVC.swift
//  Frelocate
//
//  Created by Rob Prior on 19/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController {
    
    var TableArray = [String] ()
    
    override func viewDidLoad() {
        TableArray = ["Search Properties","Sell My Property","My Saved Properties","Map","Account Settings","Savings Calculator"]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.groupTableViewBackground
        
        return cell
    }
}
