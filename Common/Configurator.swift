//
//  Configurator.swift
//  MoneyBack
//
//  Created by Damian Ferrai on 3/23/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import Foundation

// TODO add description
/// Configurator
public protocol Configurator {
    func configure(viewController: UIViewController)
}

// TODO add description
/// ConfiguratorProvider
public protocol ConfiguratorProvider {
    var sharedConfigurator: Configurator { get }
}
