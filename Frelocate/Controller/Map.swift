//
//  Map.swift
//  Frelocate
//
//  Created by Rob Prior on 21/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation

class Map: UIViewController {
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
}
