//
//  SignInConfigurator.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/8/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import Common

// MARK: Connect View, Interactor, and Presenter

extension SignInViewController: SignInPresenterOutput {}

extension SignInInteractor: SignInViewControllerOutput {}

extension SignInPresenter: SignInInteractorOutput {}

class SignInConfiguratorProvider: ConfiguratorProvider {

    static var sharedInstance = SignInConfiguratorProvider()

    var sharedConfigurator: Configurator = SignInConfigurator()

    private init() {}

    private class SignInConfigurator: Configurator {
        
        // MARK: Configuration
        
        func configure(viewController: UIViewController) {
            let signInVC = viewController as? SignInViewController
            
            let router = SignInRouter()
            router.viewController = signInVC
            GIDSignIn.sharedInstance().uiDelegate = router
            
            let presenter = SignInPresenter()
            presenter.output = signInVC
            
            let interactor = SignInInteractor()
            interactor.output = presenter
            
            signInVC?.output = interactor
            signInVC?.router = router
        }
    }
}
