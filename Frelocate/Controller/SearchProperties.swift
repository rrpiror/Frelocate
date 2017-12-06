//
//  SearchHomes.swift
//  Frelocate
//
//  Created by Rob Prior on 20/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation

class SearchProperties: UIViewController {
    override func viewDidLoad() {
       
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}
