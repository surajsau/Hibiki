//
//  FirstViewController.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 04/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import UIKit

class TrendsViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        Repository.instance.trends(onError: { error in
            self.showError(error: error?.localizedDescription)
        })
    }

}

extension TrendsViewController {
    
    private func showError(error: String?) {
        guard let error = error else {
            return
        }
        
        let vc = UIAlertController(title: "エラー", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        vc.addAction(ok)
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
