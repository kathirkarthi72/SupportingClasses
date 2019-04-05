//
//  CustomAlertAction.swift
//  CustomAlert
//
//  Created by Kathiresan  on 04/04/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import Foundation
import UIKit

/// Custom alert action
class CustomAlertAction: NSObject, NSCopying {
    
    /// Action title
    var actionTitle: String!
    
    /// Action style
    var style: UIAlertAction.Style!
    
    /// Completion handler
    var completionHandler :((_ alertAction: CustomAlertAction) -> ())!
    
    init(title: String, actionStyle: UIAlertAction.Style, handle: @escaping ((_ alertAction: CustomAlertAction) -> ())) {
       
        self.actionTitle = title
        self.style = actionStyle
        completionHandler = handle
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = CustomAlertAction(title: actionTitle, actionStyle: style, handle: completionHandler)
        return copy
    }
    
}
