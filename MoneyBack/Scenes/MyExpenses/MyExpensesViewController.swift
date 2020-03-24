//
//  MyExpensesViewController.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import Common
import SwiftSpinner

protocol MyExpensesViewControllerInput {
    func displayExpenses(viewModel: MyExpensesViewModel)
    func displaySuccessMessage(message: String)
    func displayErrorMessage(message: String)
}

protocol MyExpensesViewControllerOutput {
    func getExpenses()
    func addExpense(expenseData: MyExpensesViewModel.DisplayedExpense)
}

class MyExpensesViewController: UITableViewController, MyExpensesViewControllerInput, BaseViewController {
    var output: MyExpensesViewControllerOutput!
    var router: MyExpensesRouter!
    var expenses: [MyExpensesViewModel.DisplayedExpense] = []
    
    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        MyExpensesConfigurator.sharedInstance.configure(self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide unused rows
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.getExpenses()
    }
    
    // MARK: UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.expenses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MyExpensesViewCell? = tableView.dequeueReusableCellWithIdentifier("MyExpensesViewCell") as? MyExpensesViewCell
        cell!.configureForExpense(self.expenses[indexPath.row])
        
        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let expenseSelected: MyExpensesViewModel.DisplayedExpense = self.expenses[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Borrar") { (action, indexPath ) -> Void in
            self.editing = false
            self.expenses.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        }
        
        let sendAction = UITableViewRowAction(style: .Default, title: "Enviar") { (action, indexPath) -> Void in
            self.editing = false
            self.output.addExpense(expenseSelected)
        }
        sendAction.backgroundColor = UIColor.blueColor()
        
        let editAction = UITableViewRowAction(style: .Default, title: "Editar") { (action, indexPath) -> Void in
            self.editing = false
            self.router.editExpense(expenseSelected)
        }
        editAction.backgroundColor = UIColor.grayColor()
        
        if let expenseStatus = expenseSelected.status where !expenseStatus.isEmpty {
            
            switch expenseStatus {
            case Constants.ExpenseStatusConst.StateApproved.rawValue:
                return [deleteAction]
            case Constants.ExpenseStatusConst.StateIncomplete.rawValue:
                return [editAction, deleteAction]
            default:
                return [sendAction]
            }
        }
        
        return nil
    }
    
    
    // MARK: Event handling

    func getExpenses() {
        SwiftSpinner.show(Constants.Messages.Loading.rawValue)
        self.output.getExpenses()
    }

    // MARK: Display logic

    func displayExpenses(viewModel: MyExpensesViewModel) {
        self.expenses = viewModel.displayedExpenses
        self.tableView.reloadData()
        SwiftSpinner.hide()
    }
    
    func displaySuccessMessage(message: String) {
        self.router.showSuccessMessage(message, viewController: self)
    }
    
    func displayErrorMessage(message: String) {
        self.router.showErrorMessage(message, viewController: self)
    }
}
