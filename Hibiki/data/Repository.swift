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
    
    private var messagesCursor: String? = nil
    
    private init() {
        self.defaults = UserDefaults.standard
        self.swifter = Swifter(
            consumerKey: Secrets.CONSUMER_KEY,
            consumerSecret: Secrets.CONSUMER_SECRET
        )
    }
    
    func login(_ vc: UIViewController, callback: @escaping (_ error: Error?) -> Void) {
        self.swifter.authorize(withCallback: Constants.CALLBACK_URL!, presentingFrom: vc, success: { token, response in
            guard let token = token else {
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
            guard let tokyo = json[0]["woeid"].double else {
                let error = NSError(domain: "Empty response", code: -1, userInfo: nil)
                onError(error)
                return
            }
            
            self.trends(with: "\(tokyo)", onError: onError)
        }, failure: { error in
            onError(error)
        })
    }
    
    func feed(onSuccess: @escaping ([Feed]?) -> Void, onError: @escaping (Error) -> Void) {
        self.swifter.getHomeTimeline(count: 10, success: { json in
            let feeds = json.array?.map{ item in
                item.feed()
            }
            onSuccess(feeds)
        }, failure: { error in
            onError(error)
        })
    }
    
    func messages(refresh: Bool = false, onSuccess: @escaping ([Event]?) -> Void, onError: @escaping (Error) -> Void) {
        //clear next_cursor on refresh
        if(refresh) {
            self.messagesCursor = nil
        }
        
        self.swifter.getDirectMessages(count: 20, cursor: self.messagesCursor, success: { json in
            self.messagesCursor = json["next_cursor"].string
            let events = json["events"].array?.map { item in
                item.event()
            }
            onSuccess(events)
        }, failure: { error in
            onError(error)
        })
    }
    
    private func trends(with woeid: String, onError: @escaping (_ error: Error?) -> Void) {
        self.swifter.getTrendsPlace(with: woeid, success: { json in
            print(json)
        }, failure: { error in
            print(error)
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
