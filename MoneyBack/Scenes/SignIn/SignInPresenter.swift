//
//  SignInPresenter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/8/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol SignInPresenterInput {
    func presentSignInSuccess()
    func presentSignInError(error: NSError)
}

protocol SignInPresenterOutput: class {
    func navigateToHome()
    func showErrorMessage(message: String)
}

class SignInPresenter: SignInPresenterInput {
    weak var output: SignInPresenterOutput!

    // MARK: Presentation logic

    func presentSignInSuccess() {
        output.navigateToHome()
    }

    func presentSignInError(error: NSError) {
        output.showErrorMessage(error.localizedDescription)
    }
}
