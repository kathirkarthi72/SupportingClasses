//
//  CustomDatePickerViewController.swift
//  CustomDatePicker
//
//  Created by Kathiresan on 08/04/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import UIKit

/// Custom Date picker ViewController
class CustomDatePickerViewController: UIViewController {
    
    /// From Date
    fileprivate var fromDate: Date! {
        didSet {
            datePicker.minimumDate = fromDate
        }
    }
    
    /// Popup title
    fileprivate var popupTitle: String = "" {
        didSet {
            popupTitleLabel.text = popupTitle
        }
    }
    
    /// Choosed date
    var choosedDate: Date! {
        didSet {
            let mutableAttributes = NSMutableAttributedString(string: choosedDate.day, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title3)])
            mutableAttributes.append(NSAttributedString(string: "\n" + choosedDate.time, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)]))
            
            popupChoosedDateLabel.attributedText = mutableAttributes
            datePicker.setDate(choosedDate, animated: false)
        }
    }
    
    /// Popup View
    fileprivate var popupView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Popup title label
    fileprivate var popupTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    /// Popup choosed date label
    fileprivate var popupChoosedDateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    /// Date picker
    fileprivate var datePicker: UIDatePicker = {
        
        let picker = UIDatePicker(frame: .zero)
        picker.minuteInterval = 5
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        return picker
    }()
    
    /// Okay button
    fileprivate var okButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        button.setTitle("Continue".uppercased(), for: .normal)
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Cancel button
    fileprivate var cancelButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Cancel".uppercased(), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Footer StackView
    fileprivate var footerStackView : UIStackView = {
        
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        //stack.alignment = .center
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Completion handler
    fileprivate var completionHandler: ((_ selectedDate: Date) -> ())!
    
    func okButtonSelected(_ handler : @escaping((_ selectedDate: Date) -> ())) {
        self.completionHandler = handler
    }
    
    convenience init(title: String, from minimumDate: Date) { //, completionHandler: @escaping((_ selectedDate: Date) -> ())) {
        self.init()
        
        self.fromDate = minimumDate
        self.popupTitle = title
        
        modalPresentationStyle = .overFullScreen
        
        //  self.okButtonActionCompletionHandler = completionHandler
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initail setup
    fileprivate func initialSetup() {
        popupView.addSubview(popupTitleLabel) // Add Title
        
        popupView.addSubview(popupChoosedDateLabel) // Add Choosed date
        
        popupView.addSubview(datePicker) // Add date picker
        
        footerStackView.addArrangedSubview(cancelButton)
        footerStackView.addArrangedSubview(okButton)
        popupView.addSubview(footerStackView) // Add buttons
        
        view.addSubview(popupView) // Add popup view
        
        self.choosedDate = Date()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.backgroundColor = UIColor.clear
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutSetup()
        
    }
    
    // MARK: Constraints layout
    
    /// Setup layouts for all subviews
    fileprivate func layoutSetup() {
        // Popup View layout constraints
        popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        popupView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        // Footer stack view layout constraints
        footerStackView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -40).isActive = true
        footerStackView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15).isActive = true
        footerStackView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15).isActive = true
        footerStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // Popup title layout constraints
        popupTitleLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 10).isActive = true
        popupTitleLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15).isActive = true
        popupTitleLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15).isActive = true
        popupTitleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // popup choose date label layout constraints
        popupChoosedDateLabel.topAnchor.constraint(equalTo: popupTitleLabel.bottomAnchor, constant: 2).isActive = true
        popupChoosedDateLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15).isActive = true
        popupChoosedDateLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15).isActive = true
        popupChoosedDateLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // Date picker layout constraints
        datePicker.topAnchor.constraint(equalTo: popupChoosedDateLabel.bottomAnchor, constant: 2).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 0).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: 0).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: footerStackView.topAnchor, constant: 2).isActive = true
    }
    
    // MARK: Button action
    
    /// Date changed
    @objc fileprivate func dateChanged() {
        choosedDate = datePicker.date
    }
    
    /// Cancel Button clicked
    @objc fileprivate func cancelButtonTapped() {
        print("Cancel button tapped")
        dismiss(animated: true, completion: nil)
    }
    
    /// Ok button clicked
    @objc fileprivate func okButtonTapped() {
        print("OK button tapped")
        dismiss(animated: true) {
            self.completionHandler(self.choosedDate)
        }
    }
}
