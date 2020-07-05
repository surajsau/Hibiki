//
//  User.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 05/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import Swifter

class User {
    let imageUrl: String?
    let friends: Int
    let backgroundImageUrl: String?
    let createdTs: String
    let profileUrl: String
    let name: String
    let location: String?
    let description: String?
    
    init(imageUrl: String?,
         friends: Int,
         backgroundImageUrl: String?,
         createdTs: String,
         url: String,
         name: String,
         location: String?,
         description: String?) {
        self.imageUrl = imageUrl
        self.friends = friends
        self.backgroundImageUrl = backgroundImageUrl
        self.createdTs = createdTs
        self.profileUrl = url
        self.name = name
        self.location = location
        self.description = description
    }
}

extension JSON {
    
    func user() -> User {
        return User(imageUrl: self["profile_image_url_https"].string,
                    friends: self["friends_cound"].integer ?? 0,
                    backgroundImageUrl: self["profile_background_image_url"].string,
                    createdTs: self["created_at"].string!,
                    url: self["url"].string!,
                    name: self["name"].string!,
                    location: self["location"].string,
                    description: self["description"].string)
    }
    
}
