//
//  GoogleSignInWorker.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/14/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

typealias successHandlerType = (user: User) -> Void
typealias errorHandlerType = (error: NSError) -> Void

class GoogleSignInWorker: NSObject, GIDSignInDelegate {
    var signInSuccessHandler: successHandlerType?
    var signInErrorHandler: errorHandlerType?

    // MARK: Object lifecycle

    static var sharedInstance = GoogleSignInWorker()
    
    private override init() {
        super.init()
        GIDSignIn.sharedInstance().delegate = self
    }

    // MARK: Public Methods

    func signIn(success success: successHandlerType, error: errorHandlerType) {
        self.signInSuccessHandler = success
        self.signInErrorHandler = error

        GIDSignIn.sharedInstance().signIn()
    }

    func signInSilently() {
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    func signOut() {
        GIDSignIn.sharedInstance().signOut()
    }

    // MARK: GIDSignInDelegate

    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        
        // TODO: implement kvo or notification center to let the profile view
        // that the user info may be changed
        
        if error == nil {
            let userModel = User( userId: user.userID,
                idToken: user.authentication.idToken,
                expirationDate: user.authentication.accessTokenExpirationDate,
                name: user.profile.name,
                email: user.profile.email,
                profileURL: user.profile.hasImage ? user.profile.imageURLWithDimension(80).absoluteString : String()
            )
            self.signInSuccessHandler? (user: userModel)
        } else {
            self.signInErrorHandler? (error: error)
        }
    }
}
