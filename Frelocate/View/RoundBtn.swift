//
//  RoundBtn.swift
//  Frelocate
//
//  Created by Rob Prior on 27/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
    }

}
