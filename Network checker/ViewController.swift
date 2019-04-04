//
//  ViewController.swift
//  Network
//
//  Created by Kathiresan  on 04/04/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkChecker()
    }
    
    /// Network checker
    func networkChecker() {
        //Handle your network updations
        let networkConnection = NetworkConnection()
        networkConnection.networkMonitor { (isConnected, connection) in
            if isConnected {
                let mainQueue = DispatchQueue.main
                mainQueue.async {
                    self.view.backgroundColor = UIColor.green.withAlphaComponent(0.9)
                    self.title = "Network connected to \(connection!)"
                }
            } else {
                let mainQueue = DispatchQueue.main
                mainQueue.async {
                    self.view.backgroundColor = UIColor.orange.withAlphaComponent(0.8)
                    self.title = "Network not connected"
                }
            }
        }
    }
}

