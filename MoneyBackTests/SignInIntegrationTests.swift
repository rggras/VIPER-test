//
//  SignInIntegrationTests.swift
//  MoneyBack
//
//  Created by Damian Ferrai on 3/21/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import XCTest
import Common

class MockedSignInRouter: MainRouter, SignInRouterInput, GIDSignInUIDelegate {
    var navigateToMainTabBarCount: Int = 0
    var showErrorMessageCount: Int = 0
    
    weak var viewController: SignInViewController! // @TODO this should go in the protocol?
    
    func navigateToMainTabBar() {
        self.navigateToMainTabBarCount += 1
    }
    
    func showErrorMessage(message: String) {
        self.showErrorMessageCount += 1
    }
}

class TestSignInConfigurator: Configurator {
    // @TODO use other instances
    
    var signInRouter = MockedSignInRouter()
    //var signInPresenter = MockedSignInPresenter()
    
    func configure(viewController: UIViewController) {
        let signInVC = viewController as? SignInViewController
        
        self.signInRouter.viewController = signInVC
        GIDSignIn.sharedInstance().uiDelegate = self.signInRouter
        
        let presenter = SignInPresenter()
        presenter.output = signInVC
        
        let interactor = SignInInteractor()
        interactor.output = presenter
        
        signInVC?.output = interactor
        signInVC?.router = self.signInRouter
    }
}

class SignInIntegrationTests: XCTestCase {
    
    var signInViewController: SignInViewController! = {
        let bundle = NSBundle(forClass: SignInIntegrationTests.self)
        let storyboard = UIStoryboard(name: "SignInViewController", bundle: bundle)
        let vc = storyboard.instantiateInitialViewController() as? SignInViewController
        return vc
    }()
    
    var testSignInConfigurator = TestSignInConfigurator()
    
    override func setUp() {
        super.setUp()
        
        SignInConfiguratorProvider.sharedInstance.sharedConfigurator = self.testSignInConfigurator
        testSignInConfigurator.configure(self.signInViewController)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNavigateToHomeIntegration() {
        
        XCTAssert(testSignInConfigurator.signInRouter.navigateToMainTabBarCount == 0)
        
        self.signInViewController?.navigateToHome()
        
        XCTAssert(testSignInConfigurator.signInRouter.navigateToMainTabBarCount == 1)
        XCTAssert(testSignInConfigurator.signInRouter.showErrorMessageCount == 0)
    }
}
