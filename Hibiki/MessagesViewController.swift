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
    
    @IBOutlet var messages: UITableView!
    
    override func viewDidLoad() {
        messages.delegate = self
        messages.dataSource = self
        
        messages.register(MessagesCellView.self, forCellReuseIdentifier: "Message Cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Repository.instance.messages(refresh: true, onSuccess: { events in
            self.items = events
            self.messages.reloadData()
        }, onError: { error in
            self.showError(error: error.localizedDescription)
        })
    }
    
}

extension MessagesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //..on row selected
    }
    
}

extension MessagesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Message Cell", for: indexPath) as? MessagesCellView
        guard let item = self.items?[indexPath.row] else {
            return cell!
        }
        
        cell?.bind(event: item)
        
        return cell!
    }
    
}

extension MessagesViewController {
    
    func showError(error: String?) {
        let vc = UIAlertController(title: "エラー", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        vc.addAction(ok)
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
