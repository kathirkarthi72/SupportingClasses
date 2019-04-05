//
//  ViewController.swift
//  CustomAlert
//
//  Created by Kathiresan  on 04/04/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func alert(_ sender: Any) {
        
        let okbutton = CustomAlertAction(title: "OK", actionStyle: .default) { (alertAction) in
            print("ok Action clicked")
        }
        
        let cancelbutton = CustomAlertAction(title: "Cancel", actionStyle: .destructive) { (alertAction) in
            print("cancel Action clicked")
        }
        
        let alert = CustomAlertViewController(title: "Hello world",
                                              message: "New Custom alert",
                                              alertStyle: .alert,
                                              actions: [okbutton, cancelbutton])
        // alert.buttonAlignAxis = .vertical
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func sheet(_ sender: Any) {
        
        let okbutton = CustomAlertAction(title: "OK", actionStyle: .default) { (alertAction) in
            print("ok Action clicked")
        }
        
        let cancelbutton = CustomAlertAction(title: "Cancel", actionStyle: .destructive) { (alertAction) in
            print("cancel Action clicked")
        }
        
        let alert = CustomAlertViewController(title: "Hello world",
                                              message: "New Custom sheet",
                                              alertStyle: .actionSheet,
                                              actions: [okbutton, cancelbutton])
        alert.buttonAlignAxis = .vertical
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

