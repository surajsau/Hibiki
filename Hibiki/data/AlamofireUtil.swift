//
//  AlamofireUtil.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 04/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        return self
    }
    
}
