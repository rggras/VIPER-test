//
//  ProfileRouter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/20/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol ProfileRouterInput {
    func navigateToSignIn()
}

class ProfileRouter: MainRouter, ProfileRouterInput {
    weak var viewController: ProfileViewController!

    // MARK: Navigation
    
    func navigateToSignIn() {
        super.navigateToSignIn(self.viewController.view.window!)
    }

}
