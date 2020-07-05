//
//  MessagesCellView.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 05/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import UIKit

class MessagesCellView: UITableViewCell {

    @IBOutlet var username: UILabel!
    @IBOutlet var timestamp: UILabel!
    @IBOutlet var message: UILabel!
    
    func bind(event: Event) {
        username.text = event.messageCreate?.senderId
        timestamp.text = event.created_ts
        message.text = event.messageCreate?.messageData?.text
    }
    
}
