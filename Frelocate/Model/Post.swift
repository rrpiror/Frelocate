//
//  Post.swift
//  Frelocate
//
//  Created by Rob Prior on 03/01/2018.
//  Copyright © 2018 Rob Prior. All rights reserved.
//

import Foundation

class Post {
    private var _description: String!
    private var _imageUrl: String!
    private var _location: String!
    private var _value: String!
    private var _postKey: String!
    
    var description: String {
        return _description
    }
    var imageUrl: String {
        return _imageUrl
    }
    var location: String {
        return _location
    }
    var value: String {
        return _value
    }
    var postKey: String {
        return _postKey
    }
    
    init(description: String, imageUrl: String, location: String, value: String, postKey: String) {
        self._description = description
        self._imageUrl = imageUrl
        self._location = location
        self._value = value
        self._postKey = postKey
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let description = postData["description"] as? String {
            self._description = description
        }
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        if let location = postData["location"] as? String {
            self._location = location
        }
        if let value = postData["value"] as? String {
            self._value = value
        }
        
        
    }
    
}

















//15:00 minutes in
