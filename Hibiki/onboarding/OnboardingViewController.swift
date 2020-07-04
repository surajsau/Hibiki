//
//  Onboarding.swift
//  Hibiki
//
//  Created by emp-private-mac-suraj on 04/07/20.
//  Copyright © 2020 Goodpatch. All rights reserved.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    
    @IBAction func login(_ sender: Any) {
        Repository.instance.login(self, callback: { error in
            if error != nil {
                self.showError(error: error?.localizedDescription)
            } else {
                self.openMain()
            }
        })
    }
    
    func openMain() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Tabs")
        
        self.present(vc, animated: true, completion: nil)
    }
    
}

// Show error
extension OnboardingViewController {
    
    func showError(error: String?) {
        guard let error = error else { return }
        
        let vc = UIAlertController(title: "エラー", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        vc.addAction(ok)
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
