//
//  MessagesViewController.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 04/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import UIKit

class MessagesViewController: UIViewController {
    
    private var items: [Event]? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        Repository.instance.messages(refresh: true, onSuccess: { events in
            
        }, onError: { error in
            
        })
    }
    
}
