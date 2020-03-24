//
//  BaseRouter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/29/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import UIKit

/// Generic base router
public protocol BaseRouter {
    
    /// Present the given message into an error Alert view
    func showErrorMessage(message: String, viewController: UIViewController)
    /// Display an alert view with a message
    func showSuccessMessage(message: String, viewController: UIViewController)
    /// Display an alert view with title/message and cancel button
    func showMessage(message: String, withTitle title: String, hasCancelButton: Bool, viewController: UIViewController)
}

/// Default behavior for BaseRouter protocol
public extension BaseRouter {
    
    /// Present the given message into an error Alert view. 
    /// "Error" is the default title
    /// "Tap" is the default Action
    /// - parameter message: the message to be shown in the alert view
    /// - parameter title: the title to be shown in the alert view
    /// - parameter hasCancelButton: add an extra cancel button
    /// - parameter viewController: the view controller that present the alert view
    func showMessage(message: String, withTitle title: String, hasCancelButton: Bool = false, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        if hasCancelButton {
            alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        }
        
        
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
     /// Display an alert view with an error message
     /// - parameter message:        message
     /// - parameter viewController: viewController
    func showErrorMessage(message: String, viewController: UIViewController) {
        self.showMessage(message, withTitle: "ERROR", hasCancelButton: false, viewController: viewController)
    }
    
    /// Display an alert view with a success message
    /// - parameter message:        message
    /// - parameter viewController: viewController
    func showSuccessMessage(message: String, viewController: UIViewController) {
        self.showMessage(message, withTitle: "SUCCESS", hasCancelButton: false, viewController: viewController)
    }
}
