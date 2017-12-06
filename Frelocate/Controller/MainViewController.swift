//
//  MainViewController.swift
//  Frelocate
//
//  Created by Rob Prior on 19/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var Open: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Open.target = self.revealViewController()
        Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    

}
