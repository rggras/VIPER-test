//
//  ProfilePresenter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/20/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol ProfilePresenterInput {
    func presentCurrentUser(response: ProfileResponse)
    func presentSignOutSuccess()
}

protocol ProfilePresenterOutput: class {
    func displayCurrentUser(viewModel: ProfileViewModel)
    func navigateToSignIn()
}

class ProfilePresenter: ProfilePresenterInput {
    weak var output: ProfilePresenterOutput!

    // MARK: Presentation logic

    func presentCurrentUser(response: ProfileResponse) {
        let viewModel = ProfileViewModel(avatarUrl: response.avatarUrl, name: response.name, email: response.email)
        output.displayCurrentUser(viewModel)
    }
    
    func presentSignOutSuccess() {
        self.output.navigateToSignIn()
    }
}
