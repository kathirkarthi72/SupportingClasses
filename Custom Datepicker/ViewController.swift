//
//  ViewController.swift
//  CustomDatePicker
//
//  Created by Kathiresan  on 08/04/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = CustomDatePickerViewController(title: "Schedule", from: Date())
        picker.okButtonSelected { (selectedDate) in
            print(selectedDate.time)
            print(selectedDate.day)
        }
        
        DispatchQueue.main.async {
            self.present(picker, animated: true, completion: nil)
        }
    }
}
