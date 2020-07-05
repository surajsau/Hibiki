//
//  Feed.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 05/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import Swifter

class Feed {
    let text: String?
    let user: User
    let id: String
    let favoriteCount: Int
    let retweetCount: Int
    let inlineUrls: [InlineUrl]?
    let hashTags: [HashTag]?
    
    init(text: String?,
         user: JSON,
         id: String,
         favoriteCount: Int,
         retweetCount: Int,
         inlineUrls: [JSON]?,
         hashTags: [JSON]?) {
        self.text = text
        self.user = user.user()
        self.id = id
        self.retweetCount = retweetCount
        self.favoriteCount = favoriteCount
        self.inlineUrls = inlineUrls?.map{ url in
            url.inlineUrl()
        }
        self.hashTags = hashTags?.map { hashTag in
            hashTag.hashTag()
        }
    }
}

extension JSON {
    
    func feed() -> Feed {
        return Feed(text: self["text"].string,
                    user: self["user"],
                    id: self["id_str"].string!,
                    favoriteCount: self["favorite_count"].integer ?? 0,
                    retweetCount: self["retweet_count"].integer ?? 0,
                    inlineUrls: self["urls"].array,
                    hashTags: self["hashtags"].array)
    }
    
}
