//
//  PostCell.swift
//  Frelocate
//
//  Created by Rob Prior on 23/12/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
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
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.titleLabel.text = post.title
        self.valueLabel.text = post.value
        self.locationLabel.text = "\(post.street), \(post.location)"
        
        if img != nil {
            self.postImage.image = img
        } else {
    
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("ROB: Unable to download image from firebase storage")
                } else {
                    print("ROB: Image downloaded from firebase storage")
                    if let imageData = data {
                        if let img = UIImage(data: imageData) {
                            self.postImage.image = img
                            SearchProperties.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
        }
    }
}
    

