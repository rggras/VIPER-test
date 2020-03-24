//
//  SignInViewController.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/8/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import Common

protocol SignInViewControllerInput {
    func navigateToHome()
    func showErrorMessage(message: String)
}

protocol SignInViewControllerOutput {
    func googleSignIn()
}

class SignInViewController: UIViewController, SignInViewControllerInput, BaseViewController {
    var output: SignInViewControllerOutput!
    var router: SignInRouterInput!

    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        SignInConfiguratorProvider.sharedInstance.sharedConfigurator.configure(self)
    }

    // MARK: Actions

    @IBAction func onGoogleSignInPressed(sender: UIButton) {
        self.output.googleSignIn()
    }

    // MARK: Display logic

    func navigateToHome() {
        self.router.navigateToMainTabBar()
    }

    func showErrorMessage(message: String) {
        self.router.showErrorMessage(message)
    }
}
