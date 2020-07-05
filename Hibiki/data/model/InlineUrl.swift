//
//  InlineUrl.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 05/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import Swifter

class InlineUrl {
    let expanded: String
    let short: String
    let indices: [Int]?
    
    init(expanded: String,
         short: String,
         indices: [Int]?) {
        self.expanded = expanded
        self.short = short
        self.indices = indices
    }
}

extension JSON {
    
    func inlineUrl() -> InlineUrl {
        return InlineUrl(expanded: self["expanded_url"].string!,
                         short: self["url"].string!,
                         indices: self["indices"].array?.map{ index in index.integer ?? 0 })
    }
    
}
