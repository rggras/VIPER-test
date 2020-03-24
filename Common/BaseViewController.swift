//
//  BaseViewController.swift
//  MoneyBack
//
//  Created by Damian Ferrai on 3/23/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import UIKit

/// Generic base view controller
public protocol BaseViewController {
    
    /// Instantiate and return a view controller based on Storyboard
    /// - returns: instantiated view controler
    static func instantiateFromStoryboard(bundle: NSBundle) -> UIViewController
}

/// Default behavior for BaseViewController protocol
public extension BaseViewController where Self: UIViewController {

    /// Instantiate and return the initial view controller matching class
    // Storyboard name. Also, view controller identifier must match class name
    /// - parameter bundle: the bundle for the storyboard
    /// - returns: instantiated view controler
    static func instantiateFromStoryboard(bundle: NSBundle = NSBundle.mainBundle()) -> UIViewController {
        let storyboard = UIStoryboard(name: String(self), bundle:bundle)
        return storyboard.instantiateViewControllerWithIdentifier(String(self))
    }
}
