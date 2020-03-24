//
//  FileNumberConfigurator.swift
//  MoneyBack
//
//  Created by Gerson Villanueva on 5/2/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension FileNumberViewController: FileNumberPresenterOutput {}

extension FileNumberInteractor: FileNumberViewControllerOutput {}

extension FileNumberPresenter: FileNumberInteractorOutput {}

class FileNumberConfigurator {

    // MARK: Object lifecycle

    static var sharedInstance = FileNumberConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: FileNumberViewController) {
        let router = FileNumberRouter()
        router.viewController = viewController

        let presenter = FileNumberPresenter()
        presenter.output = viewController

        let interactor = FileNumberInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
