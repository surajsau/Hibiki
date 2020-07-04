//
//  Repository.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 04/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import Firebase
import Alamofire

class Repository {
    let provider: OAuthProvider
    
    let defaults: UserDefaults
    
    static let instance = Repository()
    
    private init() {
        self.defaults = UserDefaults.standard
        self.provider = OAuthProvider(providerID: "twitter.com")
    }
    
    func auth() -> Auth {
        return Firebase.Auth.auth()
    }
    
    func isSignedIn() -> Bool {
        return self.defaults.string(forKey: "access_token") != nil
    }
    
    func saveResult(result: AuthDataResult) {
        let credentials = result.credential as! OAuthCredential
        self.defaults.set(credentials.accessToken, forKey: "access_token")
    }
    
    func trends(onSuccess: @escaping (_ data: Data) -> Void, onError: @escaping (_ error: String?) -> Void) {
        get(url: "https://api.twitter.com/1.1/trends/place.json", onSuccess, onError)
    }
    
    private func get(url: String, _ onSuccess: @escaping (_ data: Data) -> Void, _ onError: @escaping (_ error: String?) -> Void) {
        let request = AF.request(url, method: .get, headers: headers())
        request.responseJSON { data in
            print(data)
            if data.error != nil {
                onError(data.error!.errorDescription)
                return
            }
            
            onSuccess(data.data!)
        }
    }
    
    private func headers() -> HTTPHeaders? {
        guard let accessToken = self.defaults.string(forKey: "access_token") else {
            return nil
        }
        
        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "Accept": "application/json"
        ]
        return headers
    }
}
