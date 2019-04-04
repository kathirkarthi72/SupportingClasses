//
//  ViewController.swift
//  Network
//
//  Created by Premkumar  on 04/04/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var internalBrowser: InternalBrowser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        internalBrowser = InternalBrowser(loadUrl: URL(string: "https://www.google.co.in")!)
        internalBrowser.delegate = self
        internalBrowser.startLoading()
    }
}

extension ViewController: InternalBrowserDelegate {
    func browserWillAppear(_ browser: InternalBrowser) {
        // add code here
    }
    
    func browserWillDisappear(_ browser: InternalBrowser) {
        // add code here
    }
}

