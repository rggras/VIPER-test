//
//  MyExpensesViewControllerTests.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/13/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

@testable import MoneyBack
import XCTest

class MyExpensesViewControllerTests: XCTestCase {

    // MARK: Subject under test

    var sut: MyExpensesViewController!
    var window: UIWindow!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMyExpensesViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMyExpensesViewController() {
        let bundle = NSBundle(forClass: MyExpensesViewControllerTests.self)
        self.sut = MyExpensesViewController.instantiateFromStoryboard(bundle) as? MyExpensesViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }

    // MARK: Test doubles

    class MyExpensesViewControllerOutputSpy: MyExpensesViewControllerOutput {
        var getExpensesCalled = false
        var refreshUserInformationCalled = false
        var addExpenseCalled = false
        
        // MARK: Spied methods
        func getExpenses() {
            getExpensesCalled = true
        }
        
        func refreshUserInformation() {
            refreshUserInformationCalled = true
        }

        func addExpense(expenseData: MyExpensesViewModel.DisplayedExpense) {
            addExpenseCalled = true
        }
    }
    
    class TableViewSpy: UITableView {
        var reloadDataCalled = false
        
        // MARK: Spied methods
        override func reloadData() {
            reloadDataCalled = true
        }
    }

    // MARK: Tests

    func testShouldGetExpensesWhenViewIsLoaded() {
        
        // Given
        let myExpensesViewControllerOutputSpy = MyExpensesViewControllerOutputSpy()
        sut.output = myExpensesViewControllerOutputSpy
        
        // When
        loadView()
        
        // Then
        XCTAssert(myExpensesViewControllerOutputSpy.getExpensesCalled, "Should get expenses when the view is loaded")
    }

    func testShouldRefreshUserInformationWhenViewIsLoaded() {
        
        // Given
        let myExpensesViewControllerOutputSpy = MyExpensesViewControllerOutputSpy()
        sut.output = myExpensesViewControllerOutputSpy
        
        // When
        loadView()
        
        // Then
        XCTAssert(myExpensesViewControllerOutputSpy.refreshUserInformationCalled, "Should refresh user information when the view is loaded")
    }

    func testShouldDisplayExpenses() {
        
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy

        let displayedExpense = MyExpensesViewModel.DisplayedExpense(ticketNumber: "123456", date: "10/10/10", status: "ready", amount: "$ 40", projectName: "Test", subject: "test", coin: "pesos")
        
        let viewModel = MyExpensesViewModel(displayedExpenses: [displayedExpense])
        
        // When
        sut.displayExpenses(viewModel)
        
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying expenses should reload the table view")
    }

    func testShouldConfigureTableViewCellToDisplayExpenses() {
        
        // Given
        let myExpensesViewControllerOutputSpy = MyExpensesViewControllerOutputSpy()
        sut.output = myExpensesViewControllerOutputSpy
        let displayedExpense = MyExpensesViewModel.DisplayedExpense(ticketNumber: "123456", date: "10/10/10", status: "ready", amount: "$ 40", projectName: "Test", subject: "test", coin: "pesos")
        let viewModel = MyExpensesViewModel(displayedExpenses: [displayedExpense])
        sut.displayExpenses(viewModel)
        
        // When
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAtIndexPath: indexPath) as? MyExpensesViewCell
        
        // Then
        XCTAssertEqual(cell!.projectLabel!.text, "Test", "A properly configured table view cell should display the expense ticket number")
        XCTAssertEqual(cell!.dateLabel!.text, "10/10/10", "A properly configured table view cell should display the expense date")
        XCTAssertEqual(cell!.amountLabel!.text, "$ 40", "A properly configured table view cell should display the expense amount")
    }
}
