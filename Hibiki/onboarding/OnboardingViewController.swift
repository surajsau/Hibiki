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
    
    override func viewDidLoad() {
        if(Repository.instance.isSignedIn()) {
            self.openMain()
        }
    }
    
    @IBAction func login(_ sender: Any) {
        Repository.instance.provider.getCredentialWith(nil) { credential, error in
            if error != nil {
                self.showError(error: error?.localizedDescription)
            }

            if credential != nil {
                Repository.instance.auth().signIn(with: credential!) { authResult, error in
                    if error != nil {
                        self.showError(error: error?.localizedDescription)
                    }

                    guard let authResult = authResult else {
                        self.showError(error: "Empty AuthResult")
                        return
                    }
                    
                    Repository.instance.saveResult(result: authResult)
                    
                    self.openMain()
                }
            }
        }
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
