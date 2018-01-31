//
//  Post.swift
//  Frelocate
//
//  Created by Rob Prior on 03/01/2018.
//  Copyright © 2018 Rob Prior. All rights reserved.
//

import Foundation

class Post {
    private var _title: String!
    private var _imageUrl: String!
    private var _location: String!
    private var _value: String!
    private var _street: String!
    private var _detailedDescription: String!
    private var _postKey: String!
    private var _email: String!
    
    var detailedDescription: String {
        return _detailedDescription
    }
    var street: String {
        return _street
    }
    var title: String {
        return _title
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
    var email: String {
        return _email
    }
    
    init(detailedDescription: String, street: String, description: String, imageUrl: String, location: String, value: String, postKey: String) {
        self._street = street
        self._title = description
        self._imageUrl = imageUrl
        self._location = location
        self._value = value
        self._detailedDescription = detailedDescription
        self._postKey = postKey
        self._email = email
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let detailedDescription = postData["detailedDescription"] as? String {
            self._detailedDescription = detailedDescription
        }
        if let street = postData["street"] as? String {
            self._street = street
        }
        if let title = postData["title"] as? String {
            self._title = title
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
        if let email = postData["email"] as? String {
            self._email = email
        }
        
        
    }
    
}


















