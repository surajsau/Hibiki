//
//  HashTag.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 05/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import Swifter

class HashTag {
    let indices: [Int]
    let text: String
    
    init(indices: [Int],
         text: String) {
        self.text = text
        self.indices = indices
    }
}

extension JSON {
    
    func hashTag() -> HashTag {
        return HashTag(indices: self["indices"].array!.map{index in index.integer ?? 0},
                       text: self["text"].string!)
    }
}
