//
//  RoundImage.swift
//  Frelocate
//
//  Created by Rob Prior on 03/03/2018.
//  Copyright © 2018 Rob Prior. All rights reserved.
//

import Foundation

class roundImage: UIImageView {
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
        layer.cornerRadius = self.frame.size.width / 2

    }
    
}
