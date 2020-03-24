//
//  FileNumberPresenterTests.swift
//  MoneyBack
//
//  Created by Gerson Villanueva Faillace on 5/17/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

@testable import MoneyBack
import XCTest

class FileNumberPresenterTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: FileNumberPresenter!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupFileNumberPresenter()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupFileNumberPresenter() {
        sut = FileNumberPresenter()
    }
  
    // MARK: Test doubles
    
    class FileNumberPresenterOutputSpy: FileNumberPresenterOutput {
        
        // MARK: Method call expectations
        var displayFileNumberCalled = false
        var errorPresentingFileNumber = false
        var navigateToHomeWasCalled = false
        
        // MARK: Argument expectations
        var myExpensesViewModel: MyExpensesViewModel!
        
        // MARK: Spied methods
        func displayExpenses(viewModel: MyExpensesViewModel) {
            displayFileNumberCalled = true
            myExpensesViewModel = viewModel
        }
        
        func displaySuccessOrErrorMessage(message: String) {
            errorPresentingFileNumber = true
        }
        
        func displayFileNumber(value: String) {
            displayFileNumberCalled = true
        }
        
        func navigateToHome(goToMain: Bool) {
            navigateToHomeWasCalled = true
        }
    }
  
    // MARK: Tests
  
    func testPresentingFileNumber() {
        // Given
        let fileNumberPresenterOutputSpy = FileNumberPresenterOutputSpy()
        sut.output = fileNumberPresenterOutputSpy
        let fileNumberValue = "123456"
    
        // When
        sut.presentFileNumber(fileNumberValue)
        
        // Then
        XCTAssert(fileNumberPresenterOutputSpy.displayFileNumberCalled, "Presenting fetched fileNumber")
    }
    
    func testDisplaySuccessOrErrorMessage() {
        //Given
        let fileNumberPresenterOutputSpy = FileNumberPresenterOutputSpy()
        sut.output = fileNumberPresenterOutputSpy
        
        //When
        sut.presentSuccessOrErrorMessage(false, isEditing: false)
        
        //Then
        XCTAssert(fileNumberPresenterOutputSpy.errorPresentingFileNumber, "Displaying alert view with error messages")
    }
    
    func testNavigateToHome() {
        //Given
        let fileNumberPresenterOutputSpy = FileNumberPresenterOutputSpy()
        sut.output = fileNumberPresenterOutputSpy
        
        //When
        sut.presentSuccessOrErrorMessage(true, isEditing: false)
        
        //Then
        XCTAssert(fileNumberPresenterOutputSpy.navigateToHomeWasCalled, "Should navigate and display the home view")
    }
    
}
