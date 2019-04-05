//
//  CustomAlertViewController.swift
//  CustomAlert
//
//  Created by Kathiresan  on 04/04/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import UIKit

/// Custom alert viewcontroller
class CustomAlertViewController: UIViewController {
    
    /// Body stackview contains title and message labels in stackview
    fileprivate var bodyStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    /// Button stackview contains all action buttons
    fileprivate var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    /// Container stackview contains both body and button stackviews
    fileprivate var containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        // stack.backgroundColor = UIColor.black
        stack.spacing = 5
        return stack
    }()
    
    /// UIFont for Alert Title
    var titleFont: UIFont = UIFont.systemFont(ofSize: 23.0, weight: .medium)
    
    /// UIFont for Alert message
    var messageFont: UIFont = UIFont.systemFont(ofSize: 18.0, weight: .regular)
    
    /// UIFont for Actions
    var actionFont: UIFont = UIFont.systemFont(ofSize: 20.0, weight: .medium)
    
    /// estimate body content height
    fileprivate var estimateBodyHeight: CGFloat = 10.0
    
    /// Container width
    fileprivate var contentWidth =  UIScreen.main.bounds.size.width - 60
    
    /// Container height
    fileprivate var contentHeight =  UIScreen.main.bounds.size.height
    
    // MARK: Parameters
    
    /// Alert title
    fileprivate var alertTitle: String?
    
    /// Alert message
    fileprivate var alertMessage: String?
    
    /// Alert Style
    fileprivate var alertStyle: UIAlertController.Style!
    
    /// Alert actions
    fileprivate var alertActions: [CustomAlertAction] = []
    
    // MARK: UI
    
   /// Blur effect bgView
   fileprivate var bodyView: BlurEffectView = {
        let view = BlurEffectView()
        return view
    }()
    
   /// Title label
   fileprivate var titleLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
   /// Message label
   fileprivate var messageLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.init(white: 0.3, alpha: 1.0)
        return label
    }()
    
    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(title: String?, message: String, alertStyle: UIAlertController.Style = .actionSheet, actions: [CustomAlertAction]? = nil) {
        
        self.init()
        
        self.alertTitle = title
        self.alertMessage = message
        self.alertStyle = alertStyle
        self.alertActions = actions ?? []
        
        modalPresentationStyle = .overFullScreen
        
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initial setup
    fileprivate func initialSetup() {
        self.view.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        
        configTitle()
        configMessage()
        
        containerStackView.addArrangedSubview(bodyStackView)
        
        estimateBodyHeight += 20
        
        switch alertStyle! {
        case .actionSheet:
            configActionSheet()
        default:
            configAlert()
        }
    }
    
   /// Config title
   fileprivate func configTitle() {
        
        guard let alertTitle = alertTitle else { return }
        
        titleLabel.text = alertTitle
        titleLabel.font = titleFont
        
        bodyStackView.addArrangedSubview(titleLabel)
        
        let titleLabelSize = titleLabel.sizeThatFits(CGSize(width: contentWidth, height: .infinity))
        estimateBodyHeight += titleLabelSize.height + 10
        
    }
    
   /// Config Message
   fileprivate func configMessage() {
        
        guard let alertMessage = alertMessage else { return }
        
        messageLabel.text = alertMessage
        messageLabel.font = messageFont
        
        bodyStackView.addArrangedSubview(messageLabel)
        
        let messageLabelSize = messageLabel.sizeThatFits(CGSize(width: contentWidth, height: .infinity))
        estimateBodyHeight += messageLabelSize.height// + 20.0
    }
    
    /// Change button align axis
    var buttonAlignAxis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            buttonStackView.axis = buttonAlignAxis
        }
    }
    
    /// Button alignment
    fileprivate func buttonAlignment() {
        for (tag, actionButton) in alertActions.enumerated() {
            
            let blurView = BlurEffectView()
            
            let button = UIButton(type: .custom)
            button.frame.size = CGSize(width: contentWidth, height: 40.0)
            button.setTitle(actionButton.actionTitle!, for: .normal)
            button.titleLabel?.font = actionFont
            button.setTitleColor(actionButton.style == .destructive ? UIColor.red : UIColor.black, for: .normal)
            
            blurView.contentView.addSubview(button)
            button.tag = tag
            button.addTarget(self, action: #selector(actionClicked(_:)), for: .touchUpInside)
            
            buttonStackView.addArrangedSubview(button)
            
            estimateBodyHeight += 44.0
        }
    }
    
    /// Config alert
    fileprivate func configAlert() {
        
        buttonAlignment()
        
        containerStackView.addArrangedSubview(buttonStackView)
        
        bodyView.contentView.addSubview(containerStackView)
        
        bodyView.frame.size = CGSize(width: contentWidth, height: estimateBodyHeight)
        bodyView.center = view.center
        view.addSubview(bodyView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.topAnchor.constraint(equalTo: bodyView.contentView.topAnchor, constant: 0).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: bodyView.contentView.leadingAnchor, constant: 0).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: bodyView.contentView.trailingAnchor, constant: 0).isActive = true
        containerStackView.heightAnchor.constraint(equalToConstant: estimateBodyHeight).isActive = true
    }
    
    /// Config action sheet
    fileprivate func configActionSheet() {

        buttonAlignAxis = .horizontal
        
        buttonAlignment()
    
        containerStackView.addArrangedSubview(buttonStackView)
        
        bodyView.contentView.addSubview(containerStackView)
        bodyView.frame.size = CGSize(width: contentWidth, height: estimateBodyHeight)
        
        let centerPoint = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY - (bodyView.frame.height / 2) - 50)
        
        bodyView.center = centerPoint
        view.addSubview(bodyView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.topAnchor.constraint(equalTo: bodyView.contentView.topAnchor, constant: 0).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: bodyView.contentView.leadingAnchor, constant: 0).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: bodyView.contentView.trailingAnchor, constant: 0).isActive = true
        containerStackView.heightAnchor.constraint(equalToConstant: estimateBodyHeight).isActive = true
    }
    
    // MARK: Button action
    
    /// Button clicked action
    ///
    /// - Parameter sender: sender button
    @objc fileprivate func actionClicked(_ sender: UIButton) {
        let selectedAction = alertActions[sender.tag]
        selectedAction.completionHandler(selectedAction)
        
        dismiss(animated: true, completion: nil)
    }
}



/// Blur effect view
fileprivate class BlurEffectView: UIVisualEffectView {
    
    init() {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.light)
        super.init(effect: effect)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateMaskLayer()
    }
    
    func updateMaskLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 12.0).cgPath
        self.layer.mask = shapeLayer
    }
}

