//
//  MainRouter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/15/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import Foundation

class MainRouter: NSObject {

    // MARK: Navigation

    func navigateToInitialView(window: UIWindow) {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            navigateAndCheckFirstLaunch(window)
        } else {
            self.navigateToSignIn(window)
        }
    }
    
    func navigateAndCheckFirstLaunch(window: UIWindow) {
        if isFirstLaunch() {
            self.navigateToFileNumber(window)
        } else {
            self.navigateToMainTabBar(window)
        }
    }
    
    func navigateToMainTabBar(window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        window.rootViewController = storyboard.instantiateInitialViewController()!
    }
    
    func navigateToSignIn(window: UIWindow) {
        window.rootViewController = SignInViewController.instantiateFromStoryboard()
    }
    
    func navigateToNewExpense(window: UIWindow) {
        window.rootViewController = SignInViewController.instantiateFromStoryboard()
    }
    
    func navigateToFileNumber(window: UIWindow) {
        let storyboard = UIStoryboard(name: "FileNumberViewController", bundle: NSBundle.mainBundle())
        window.rootViewController = storyboard.instantiateInitialViewController()!
    }
    
    private func isFirstLaunch() -> Bool {
        var firstLaunch = NSUserDefaults.standardUserDefaults().objectForKey("firstLaunch")
        
        if firstLaunch == nil {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstLaunch")
            NSUserDefaults.standardUserDefaults().synchronize()
            firstLaunch = false
        }
        return !(firstLaunch?.boolValue)!
    }
}
