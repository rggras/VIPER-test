//
//  FileNumberInteractorTests.swift
//  MoneyBack
//
//  Created by Gerson Villanueva Faillace on 5/17/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

@testable import MoneyBack
import XCTest

class FileNumberInteractorTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: FileNumberInteractor!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupFileNumberInteractor()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupFileNumberInteractor() {
        sut = FileNumberInteractor()
    }
  
    // MARK: Test doubles
    
    class FileNumberInteractorOutputSpy: FileNumberInteractorOutput {
        
        // MARK: Method call expectations
        var presentFileNumberCalled = false
        var presentSuccessOrErrorMessageCalled = false
        
        // MARK: Spied methods
        func presentSuccessOrErrorMessage(success: Bool, isEditing: Bool) {
            presentSuccessOrErrorMessageCalled = true
        }
        
        func presentFileNumber(value: String) {
            presentFileNumberCalled = true
        }
    }
    
    class FileNumberWorkerSpy: FileNumberWorker {
        
        // MARK: Method call expectations
        var saveFileNumberCalled = false
        
        // MARK: Spied methods
        override func saveFileNumber(fileNumber: String?) {
            saveFileNumberCalled = true
        }
    }
  
    // MARK: Tests

    func testSaveFileNumber() {
        
        // Given
        let fileNumberInteractorOutputSpy = FileNumberInteractorOutputSpy()
        sut.output = fileNumberInteractorOutputSpy
        let fileNumberWorkerSpy = FileNumberWorkerSpy()
        sut.worker = fileNumberWorkerSpy
        
        // When
        sut.saveFileNumber("12345", isEditing: false)
        
        // Then
        XCTAssert(fileNumberInteractorOutputSpy.presentSuccessOrErrorMessageCalled, "saveFileNumber() should ask presenter to format filenumber result")
    }
    
    
    func testGetFileNumber() {
        
        // Given
        let fileNumberInteractorOutputSpy = FileNumberInteractorOutputSpy()
        sut.output = fileNumberInteractorOutputSpy
        let fileNumberWorkerSpy = FileNumberWorkerSpy()
        sut.worker = fileNumberWorkerSpy
        
        // When
        sut.getFileNumber()
        
        // Then
        XCTAssert(fileNumberInteractorOutputSpy.presentFileNumberCalled, "saveFileNumber() should ask presenter to format filenumber result")
    }
}
