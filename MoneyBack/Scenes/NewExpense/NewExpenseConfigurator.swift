//
//  NewExpenseConfigurator.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension NewExpenseViewController: NewExpensePresenterOutput {}

extension NewExpenseInteractor: NewExpenseViewControllerOutput {}

extension NewExpensePresenter: NewExpenseInteractorOutput {}

class NewExpenseConfigurator {

    // MARK: Object lifecycle

    static var sharedInstance = NewExpenseConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: NewExpenseViewController) {
        let router = NewExpenseRouter()
        router.viewController = viewController

        let presenter = NewExpensePresenter()
        presenter.output = viewController

        let interactor = NewExpenseInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
