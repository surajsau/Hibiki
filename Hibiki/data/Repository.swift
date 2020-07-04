//
//  Repository.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 04/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import Firebase
import Swifter

class Repository {
    
    private let defaults: UserDefaults
    private let swifter: Swifter
    
    static let instance = Repository()
    
    private init() {
        self.defaults = UserDefaults.standard
        self.swifter = Swifter(
            consumerKey: "858sxYl1edubKsweRvN4zQxb1",
            consumerSecret: "f6DYrjMGptdakQcAjSKV1YWrbgyTfCt9tXSuWwYOVQkN98CQMw"
        )
    }
    
    func login() {
        swifter.authorize(withCallback: Constants.CALLBACK_URL, presentingFrom: self, success: { token, response in
            print("Response: \(token) \(response)")
        }, failure: { error in
            print("Error: \(error)")
        })
    }
    
    func isSignedIn() -> Bool {
        return self.defaults.string(forKey: "access_token") != nil
    }
}
