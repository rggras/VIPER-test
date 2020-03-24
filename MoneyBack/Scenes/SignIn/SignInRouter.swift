//
//  SignInRouter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/8/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import Common

protocol SignInRouterInput: BaseRouter {
    func navigateToMainTabBar()
    func showErrorMessage(message: String)
}

class SignInRouter: MainRouter, SignInRouterInput, GIDSignInUIDelegate {
    weak var viewController: SignInViewController!

    // MARK: Navigation

    func navigateToMainTabBar() {
        super.navigateAndCheckFirstLaunch(self.viewController.view.window!)
    }
    
    func showErrorMessage(message: String) {
        self.showErrorMessage(message, viewController: self.viewController)
    }

    // MARK: GIDSignInUIDelegate

    // Present a view that prompts the user to sign in with Google
    @objc func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        self.viewController.presentViewController(viewController, animated: true, completion: nil)
    }

    // Dismiss the "Sign in with Google" view
    @objc func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        self.viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
