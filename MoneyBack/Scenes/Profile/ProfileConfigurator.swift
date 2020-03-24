//
//  ProfileConfigurator.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/20/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ProfileViewController: ProfilePresenterOutput {}

extension ProfileInteractor: ProfileViewControllerOutput {}

extension ProfilePresenter: ProfileInteractorOutput {}

class ProfileConfigurator {

    // MARK: Object lifecycle

    static var sharedInstance = ProfileConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: ProfileViewController) {
        let router = ProfileRouter()
        router.viewController = viewController

        let presenter = ProfilePresenter()
        presenter.output = viewController

        let interactor = ProfileInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
