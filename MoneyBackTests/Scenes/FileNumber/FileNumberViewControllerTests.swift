//
//  FileNumberViewControllerTests.swift
//  MoneyBack
//
//  Created by Gerson Villanueva Faillace on 5/17/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

@testable import MoneyBack
import XCTest

class FileNumberViewControllerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: FileNumberViewController!
    var window: UIWindow!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupFileNumberViewController()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupFileNumberViewController() {
        let bundle = NSBundle(forClass: FileNumberViewControllerTests.self)
        self.sut = FileNumberViewController.instantiateFromStoryboard(bundle) as? FileNumberViewController
    }
  
    func loadView() {
        window.addSubview(sut.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }
    
    // MARK: Test doubles
    
    class FileNumberViewControllerOutputSpy: FileNumberViewControllerOutput {
        var getFileNumberCalled = false
        var saveFileNumberCalled = false
        
        // MARK: Spied methods
        func saveFileNumber(fileNumber: String?, isEditing: Bool) {
            saveFileNumberCalled = true
        }
        
        func getFileNumber() {
            getFileNumberCalled = true
        }
    }
    
    class FileNumberRouterSpy: FileNumberRouter {
        var navigateToHomeCalled = false
        var openGLOInSafariCalled = false
        
        override func navigateToHome() {
            navigateToHomeCalled = true
        }
        
        override func openGLOInSafari() {
            openGLOInSafariCalled = true
        }

    }
    
    class FileNumberViewControllerSpy: FileNumberViewController {
        var navigateToHomeCalled = false
        var openGLOInSafariCalled = false
        
        // MARK: Spied methods
        override func navigateToHome(isEditing: Bool) {
            navigateToHomeCalled = true
        }
        
        override func openGLOInSafari() {
            openGLOInSafariCalled = true
        }
        
    }
  
    // MARK: Tests
  
    func testShouldGetFileNumberWhenViewIsLoaded() {
        
        // Given
        let fileNumberViewControllerOutputSpy = FileNumberViewControllerOutputSpy()
        sut.output = fileNumberViewControllerOutputSpy
        
        // When
        loadView()
        
        // Then
        XCTAssert(fileNumberViewControllerOutputSpy.getFileNumberCalled, "Should get file number when the view is loaded")
    }
    
    func testShouldSaveFileNumberWhenUserTappedSaveButton() {
        
        // Given
        let fileNumberViewControllerOutputSpy = FileNumberViewControllerOutputSpy()
        sut.output = fileNumberViewControllerOutputSpy
        sut.fileNumberTextField = UITextField()
        sut.fileNumberTextField.text = "12345"
        
        // When
        sut.saveButtonTapped(self)
        
        // Then
        XCTAssert(fileNumberViewControllerOutputSpy.saveFileNumberCalled, "Should save file number when user tapped save button")
    }
    
    func testShouldSaveFileNumberWhenUserTappedUpdateButton() {
        
        // Given
        let fileNumberViewControllerOutputSpy = FileNumberViewControllerOutputSpy()
        sut.output = fileNumberViewControllerOutputSpy
        sut.fileNumberTextField = UITextField()
        sut.fileNumberTextField.text = "123"
        
        // When
        sut.saveButtonTapped(self)
        
        // Then
        XCTAssert(fileNumberViewControllerOutputSpy.saveFileNumberCalled, "Should update file number when user tapped update button")
    }
    
    
    func testShouldSkipFileNumberViewWhenUserTappedSkipButton() {
        
        // Given
        let fileNumberViewControllerSpy = FileNumberViewControllerSpy()
        
        // When
        fileNumberViewControllerSpy.skipButtonTapped(self)
        
        // Then
        XCTAssert(fileNumberViewControllerSpy.navigateToHomeCalled, "Should dismiss the file number view when user tapped skip Button")
    }
    
    func testShouldOpenSafariWhenUserTappedGLOButton() {
        
        // Given
        let fileNumberViewControllerSpy = FileNumberViewControllerSpy()
        
        // When
        fileNumberViewControllerSpy.gloButtonTapped(self)
        
        // Then
        XCTAssert(fileNumberViewControllerSpy.openGLOInSafariCalled, "Should open safari when user tapped GLO Button")
    }
    
    func testShouldCallOpenSafariMethodFromRouter() {
        
        // Given
        let fileNumberRouterSpy = FileNumberRouterSpy()
        sut.router = fileNumberRouterSpy
        
        // When
        sut.openGLOInSafari()
        
        // Then
        XCTAssert(fileNumberRouterSpy.openGLOInSafariCalled, "Should open safari when user tapped GLO Button")
    }
    
    func testShouldCallNavigateToHomeMethodFromRouter() {
        
        // Given
        let fileNumberRouterSpy = FileNumberRouterSpy()
        sut.router = fileNumberRouterSpy
        
        // When
        sut.navigateToHome(false)
        
        // Then
        XCTAssert(fileNumberRouterSpy.navigateToHomeCalled, "Should open safari when user tapped GLO Button")
    }
    
    
}
