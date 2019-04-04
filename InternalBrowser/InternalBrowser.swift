//
//  BrowserView.swift
//  Internal Browser
//
//  Created by Kathiresan  on 14/03/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import UIKit
import SafariServices

/// Browser Delegate
protocol InternalBrowserDelegate: NSObjectProtocol {
    
    /// Browser will appeared
    ///
    /// - Parameter browser: browser
    func browserWillAppear(_ browser: InternalBrowser)
    
    
    /// Browser will disappear
    ///
    /// - Parameter browser: browser
    func browserWillDisappear(_ browser: InternalBrowser)
}

/// Internal browser - Safari service view controller
class InternalBrowser: NSObject {
    
    /// SafariViewController
    fileprivate var safariVC: SFSafariViewController!
    
    weak var delegate: InternalBrowserDelegate!
    
    fileprivate func config(_ loadUrl: URL) {
        
        if #available(iOS 11.0, *) {
            let config = SFSafariViewController.Configuration()
            config.barCollapsingEnabled = true
            config.entersReaderIfAvailable = true
            safariVC = SFSafariViewController(url: loadUrl, configuration: config)
        } else {
            // Fallback on earlier versions
            safariVC = SFSafariViewController(url: loadUrl)
        }
    }
    
    /// Initialize Browser
    ///
    /// - Parameter loadUrl: url
    init(loadUrl: URL) {
        super.init()
        config(loadUrl)
    }
    
    /// Start loading url on browser
    func startLoading() {
        
        DispatchQueue.global().sync {
            self.safariVC.delegate = self
        }
        
        if let delegate = delegate { delegate.browserWillAppear(self) }
        UIApplication.shared.keyWindow?.rootViewController?.present(safariVC, animated: true, completion: nil)
    }
}

// MARK: - SFSafariViewControllerDelegate
extension InternalBrowser: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        if let delegate = delegate { delegate.browserWillDisappear(self) }
    }
    
}


