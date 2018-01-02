//
//  ShadowView.swift
//  Frelocate
//
//  Created by Rob Prior on 23/12/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation

class ShadowView: UIView {
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.9
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
    
}
