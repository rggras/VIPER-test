//
//  MyExpensesViewCell.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/5/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import UIKit

class MyExpensesViewCell: UITableViewCell {
    @IBOutlet var projectLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var statusLabel: UILabel?
    @IBOutlet var amountLabel: UILabel?
    
    func configureForExpense(expense: MyExpensesViewModel.DisplayedExpense) {
        self.projectLabel?.text = expense.projectName
        self.dateLabel?.text = expense.date
        self.amountLabel?.text = expense.amount
        self.statusLabel?.text = expense.status
    }
}
