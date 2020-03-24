//
//  NewExpenseRouter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import Common

protocol NewExpenseRouterInput: BaseRouter {
    func presentEditFileNumberView(viewController: UIViewController)
}

class NewExpenseRouter: BaseRouter, NewExpenseRouterInput {
    weak var viewController: NewExpenseViewController!
    
    func presentEditFileNumberView(viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "EditFileNumberStoryboard", bundle: NSBundle.mainBundle())
        let editFileNumberVC = storyboard.instantiateInitialViewController()!
        
        editFileNumberVC.modalPresentationStyle = .OverCurrentContext
        viewController.presentViewController(editFileNumberVC, animated: true, completion: nil)
    }
}
