//
//  AppDelegate.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/7/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let router: MainRouter! = MainRouter()

    // MARK: UIApplicationDelegate

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.setupGoogleSignIn()
        self.setupWindow()
        self.setupStatusBar()
        
        self.router.navigateToInitialView(self.window!)

        return true
    }

    func application(application: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url, 
            sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
            annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }

    // MARK: Private Methods

    private func setupGoogleSignIn() {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
    }

    private func setupWindow() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.makeKeyAndVisible()
    }

    private func setupStatusBar() {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UIApplication.sharedApplication().statusBarHidden = false
    }
}
