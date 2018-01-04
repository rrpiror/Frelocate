//
//  PostCell.swift
//  Frelocate
//
//  Created by Rob Prior on 23/12/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation

class PostCell: UITableViewCell {
    
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        self.post = post
        self.descriptionLabel.text = post.description
        self.valueLabel.text = post.value
        self.locationLabel.text = post.location
    }
    
}
