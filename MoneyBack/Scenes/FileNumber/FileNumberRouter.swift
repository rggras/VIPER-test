//
//  FileNumberRouter.swift
//  MoneyBack
//
//  Created by Gerson Villanueva Faillace on 4/28/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import Common

protocol FileNumberRouterInput: BaseRouter {
    func navigateToHome()
    func openGLOInSafari()
}

class FileNumberRouter: MainRouter, BaseRouter, FileNumberRouterInput {
    weak var viewController: FileNumberViewController!
  
    // MARK: Navigation
  
    func navigateToHome() {
        super.navigateToMainTabBar(self.viewController.view.window!)
    }
    
    func openGLOInSafari() {
        UIApplication.sharedApplication().openURL(NSURL(string: Constants.FileConst.GLOUrl.rawValue)!)
    }
}
