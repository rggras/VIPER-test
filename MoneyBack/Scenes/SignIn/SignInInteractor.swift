//
//  SignInInteractor.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/8/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol SignInInteractorInput {
    func googleSignIn()
}

protocol SignInInteractorOutput {
    func presentSignInSuccess()
    func presentSignInError(error: NSError)
}

class SignInInteractor: SignInInteractorInput {
    var output: SignInInteractorOutput!
    var userDefaultsWorker: UserDefaultsWorker! = UserDefaultsWorker()

    // MARK: Business logic

    func googleSignIn() {
        GoogleSignInWorker.sharedInstance.signIn(
            success: { (user: User) -> Void in
                self.userDefaultsWorker.saveUser(user)
                self.output.presentSignInSuccess()
            },
            error: { (error: NSError) -> Void in
                self.output.presentSignInError(error)
        })
    }
}
