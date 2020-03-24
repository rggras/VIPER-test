//
//  FileNumberWorkerTests.swift
//  MoneyBack
//
//  Created by Gerson Villanueva Faillace on 5/17/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

@testable import MoneyBack
import XCTest

class FileNumberWorkerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: FileNumberWorker!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupFileNumberWorker()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupFileNumberWorker() {
        sut = FileNumberWorker()
    }
  
    // MARK: Tests
  
    func testSavingFileNumberOnUserDefault() {
        // Given
        let userDefaultsWorker = UserDefaultsWorker()
        
        // When
        sut.saveFileNumber("123456")
    
        // Then
        XCTAssertEqual(userDefaultsWorker.getFileNumber(), "123456", "The fileNumber should be equal to 123456")
    }
}
