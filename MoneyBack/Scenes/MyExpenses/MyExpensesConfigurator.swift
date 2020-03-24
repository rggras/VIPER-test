//
//  MyExpensesConfigurator.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension MyExpensesViewController: MyExpensesPresenterOutput {}

extension MyExpensesInteractor: MyExpensesViewControllerOutput {}

extension MyExpensesPresenter: MyExpensesInteractorOutput {}

class MyExpensesConfigurator {

    // MARK: Object lifecycle

    static var sharedInstance = MyExpensesConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: MyExpensesViewController) {
        let router = MyExpensesRouter()
        router.viewController = viewController

        let presenter = MyExpensesPresenter()
        presenter.output = viewController

        let interactor = MyExpensesInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
