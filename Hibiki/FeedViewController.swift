//
//  FeedViewController.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 04/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        Repository.instance.feed()
    }
    
}
