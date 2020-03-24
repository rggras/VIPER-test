//
//  ProfileInteractor.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/20/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol ProfileInteractorInput {
    func getCurrentUser(request: ProfileRequest)
    func googleSignOut()
}

protocol ProfileInteractorOutput {
    func presentCurrentUser(response: ProfileResponse)
    func presentSignOutSuccess()
}

class ProfileInteractor: ProfileInteractorInput {
    var output: ProfileInteractorOutput!
    var userDefaultsWorker: UserDefaultsWorker! = UserDefaultsWorker()

    // MARK: Business logic

    func getCurrentUser(request: ProfileRequest) {
        let user = UserDefaultsWorker().getUser()

        let response = ProfileResponse(avatarUrl: user.profileURL, name: user.name, email: user.email)
        output.presentCurrentUser(response)
    }
    
    func googleSignOut() {
        GoogleSignInWorker.sharedInstance.signOut()
        
        self.userDefaultsWorker.removeUser()
        self.output.presentSignOutSuccess()
    }
    
    /*
     func refreshUserInformation() {
     GoogleSignInWorker.sharedInstance.signInSilently()
     }
     */
}
