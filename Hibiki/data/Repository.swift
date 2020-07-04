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
            consumerKey: Secrets.CONSUMER_KEY,
            consumerSecret: Secrets.CONSUMER_SECRET
        )
    }
    
    func login(_ vc: UIViewController, callback: @escaping (_ error: Error?) -> Void) {
        self.swifter.authorize(withCallback: Constants.CALLBACK_URL!, presentingFrom: vc, success: { token, response in
            guard let token = token as? Credential.OAuthAccessToken else {
                return
            }
            
            self.defaults.set(token.userID, forKey: "user_id")
            self.defaults.set(token.screenName, forKey: "user_name")
            self.defaults.set(token.key, forKey: "token_key")
            self.defaults.set(token.secret, forKey: "token_secret")
            
            callback(nil)
        }, failure: { error in
            callback(error)
        })
    }
    
    func trends(onError: @escaping (_ error: Error?) -> Void) {
        self.swifter.getClosestTrends(for: Constants.TOKYO, success: { json in
            
        }, failure: { error in
            onError(error)
        })
    }
    
    private func trends(for woeid: String, onError: @escaping (_ error: Error?) -> Void) {
        self.swifter.getTrendsPlace(with: woeid, success: { json in
            
        }, failure: { error in
            onError(error)
        })
    }
    
    func isSignedIn() -> Bool {
        return self.defaults.string(forKey: "user_id") != nil
    }
    
    func logout() {
        self.defaults.removeObject(forKey: "user_id")
        self.defaults.removeObject(forKey: "user_name")
        self.defaults.removeObject(forKey: "token_key")
        self.defaults.removeObject(forKey: "token_secret")
    }
}
