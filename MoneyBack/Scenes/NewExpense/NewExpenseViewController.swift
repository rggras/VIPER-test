//
//  NewExpenseViewController.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import Common


protocol NewExpenseViewControllerInput {
    func displaySuccessMessage(message: String)
    func displayErrorMessage(message: String)
    func displayExpenseDate(date: String)
    func displayCoinsType(coinsType: [String])
    func displayConceptsType(conceptsType: [String])
    func displayProjectsType(projectsType: [String])
    func displayAmountNumberFormatted(value: String)
    func displayEnableButton(value: Bool)
    func displayExpandedSubjectCell(value: Bool)
}

protocol NewExpenseViewControllerOutput {
    func formatExpenseDate(request: NSDate)
    func formatAmountNumber(oldRequestValue: String, shouldReplaceInRange range: NSRange, withNewValue newRequestValue: String)
    func addExpense(expenseData: NewExpenseRequest)
    func getCoinTypes()
    func getConceptsTypes()
    func getProjects()
    func getFileNumber()
    func validateForm(expenseData: NewExpenseRequest)
    func validateExpndCell(value: String)
}

class NewExpenseViewController: UITableViewController, NewExpenseViewControllerInput, BaseViewController, UINavigationControllerDelegate {
    
    var output: NewExpenseViewControllerOutput!
    var router: NewExpenseRouterInput!
    
    var pickerElements: [String] = []
    var projectElements: [String] = []
    
    var expenseToEdit: NewExpenseRequest?
    
    var currentString = ""
    
    var expandCell = false
    
    // MARK: Text fields
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var ticketNumberTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var projectCoinTextField: UITextField!
    @IBOutlet var projectConceptCoinPicker: UIPickerView!
    @IBOutlet weak var projectDateTextField: UITextField!
    @IBOutlet var projectDatePicker: UIDatePicker!
    @IBOutlet weak var docketLabel: UILabel!
    @IBOutlet weak var buttonsContainerView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var expenseImageView: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var otherSubjectTextField: UITextField!
    // MARK: Object lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        NewExpenseConfigurator.sharedInstance.configure(self)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSaveButtonToNavigation()
        configurePickers()
        output.getProjects()
        output.getFileNumber()

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshFileNumberInfo), name: Constants.NotificationConst.DissmissViewController.rawValue, object: nil)
        
        if expenseToEdit != nil {
            self.showExpense(expenseToEdit!)
        }
    }
    
    // MARK: UITableViewDatasource
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if expandCell && indexPath.section == 0 && indexPath.row == 3 {
            return 80
        } else if indexPath.section == 2 && indexPath.row == 0 {
            return 120
        }
        
        return 44
    }
    
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            for textField in textFields {
                if textField.isDescendantOfView(cell) {
                    textField.becomeFirstResponder()
                }
            }
        }
    }
    
    func configurePickers() {
        projectDatePicker.datePickerMode = UIDatePickerMode.Date
        projectDateTextField.inputView = projectDatePicker
        projectTextField.inputView = projectConceptCoinPicker
        projectCoinTextField.inputView = projectConceptCoinPicker
        subjectTextField.inputView = projectConceptCoinPicker
    }
    
    // MARK: IBAction
    @IBAction func projectDatePickerValueChanged(sender: AnyObject) {
        let expenseDate = projectDatePicker.date
        output.formatExpenseDate(expenseDate)
    }
    
    
    @IBAction func editDocketButtonTapped(sender: AnyObject) {
        self.router.presentEditFileNumberView(self)
    }
    
    @IBAction func addImageToExpense(sender: UIButton) {
        self.selectImageFromCamera(sender.tag == 100) //Camera
    }
    
    
    @IBAction func removeImageToExpense(sender: UIButton) {
        self.buttonsContainerView.hidden = false
        self.imageContainerView.hidden = !self.buttonsContainerView.hidden
        self.expenseImageView.image = nil
        self.output.validateForm(self.getCurrentRequestForm())
    }
    
    @IBAction func sendExpense(sender: AnyObject) {
        self.sendExpenseWithStatus(Constants.ExpenseStatusConst.StatePending.rawValue)
    }
    
    // MARK: Inputs
    func displayExpenseDate(date: String) {
        projectDateTextField.text = date
    }
    
    
    func displayCoinsType(coinsType: [String]) {
        self.pickerElements = coinsType
        self.projectConceptCoinPicker.reloadAllComponents()
    }
    
    func displayConceptsType(conceptsType: [String]) {
        self.pickerElements = conceptsType
        self.projectConceptCoinPicker.reloadAllComponents()
    }
    
    
    func displayProjectsType(projectsType: [String]) {
        self.projectElements = projectsType
        self.projectConceptCoinPicker.reloadAllComponents()
    }
    
    func displayFileNumber(value: String) {
        self.docketLabel.text = value
    }
    
    func displayAmountNumberFormatted(value: String) {
        self.amountTextField.text = value
    }
    
    func displayEnableButton(value: Bool) {
        self.sendButton.enabled = value
    }
    
    // MARK: Event handling
    func addSaveButtonToNavigation() {
        // NOTE: Ask the Interactor to do some work
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .Plain, target: self, action: #selector(self.addTapped))
    }
    
    func displayExpandedSubjectCell(value: Bool) {
        self.expandCell = value
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }

    
    func addTapped(sender: UIBarButtonItem) {
        
        let refreshAlert = UIAlertController(title: "GUARDAR", message: "Desea guardar los datos cargados?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            self.sendExpenseWithStatus(nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler:nil))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    
    func sendExpenseWithStatus(status: String?) {
        var newExpense = self.getCurrentRequestForm()
        var expenseStatus: String? = status
        
        if expenseStatus == nil {
            expenseStatus = Constants.ExpenseStatusConst.StateIncomplete.rawValue
            if self.sendButton.enabled {
                expenseStatus = Constants.ExpenseStatusConst.StateReady.rawValue
            }
        }
        
        newExpense.status = expenseStatus
        output.addExpense(newExpense)
    }
    
    func getCurrentRequestForm () -> NewExpenseRequest {
        
        var subjectExpense = subjectTextField.text
        if subjectExpense == Constants.ExpenseConst.Others.rawValue {
            subjectExpense = otherSubjectTextField.text
        }
        
        
        return NewExpenseRequest(projectName: projectTextField.text, date: projectDateTextField.text, docketNumber: docketLabel.text, subject: subjectExpense, ticketNumber: ticketNumberTextField.text, amount: amountTextField.text, coin: projectCoinTextField.text, attachedImage: self.expenseImageView.image, status: nil)
    }
    
    
    // MARK: Display logic
    func displaySuccessMessage(message: String) {
        self.router.showSuccessMessage(message, viewController: self)
    }
    func displayErrorMessage(message: String) {
        self.router.showErrorMessage(message, viewController: self)
    }
    
    @objc func refreshFileNumberInfo() {
        output.getFileNumber()
    }
    
    //MARK: Privates
    func selectImageFromCamera(showCamera: Bool) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        var source = UIImagePickerControllerSourceType.Camera
        
        if !showCamera {
            source = .PhotoLibrary
        }
        
        imagePicker.sourceType = source
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func showExpense(expenseToShow: NewExpenseRequest) {
        
        if let subject = expenseToShow.subject where !subject.isEmpty {
            self.subjectTextField.text = expenseToShow.subject
            if !Constants.ExpenseConst.allConcepts.contains(subject) {
                self.subjectTextField.text = Constants.ExpenseConst.Others.rawValue
                self.otherSubjectTextField.text = subject
            }
            
            self.output.validateExpndCell(subjectTextField.text!)
        }
        
        self.projectTextField.text = expenseToShow.projectName
        self.ticketNumberTextField.text = expenseToShow.ticketNumber
        self.amountTextField.text = expenseToShow.amount
        self.projectCoinTextField.text = expenseToShow.coin
        self.projectDateTextField.text = expenseToShow.date
        self.docketLabel.text = expenseToShow.docketNumber
        self.expenseImageView.image = expenseToShow.attachedImage
    }
}

//MARK: UITextFieldDelegate
extension NewExpenseViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let index = textFields.indexOf(textField) {
            if index < textFields.count - 1 {
                let nextTextField = textFields[index + 1]
                nextTextField.becomeFirstResponder()
            }
        }
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField.isEqual(self.projectTextField) {
            pickerElements = projectElements
        } else if textField.isEqual(self.projectCoinTextField) {
            output.getCoinTypes()
        } else if textField.isEqual(self.subjectTextField) {
            output.getConceptsTypes()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.output.validateForm(self.getCurrentRequestForm())
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool { //
        
        if textField.isEqual(self.amountTextField) && !(self.amountTextField.text?.isEmpty)! {
            output.formatAmountNumber(self.amountTextField.text!, shouldReplaceInRange: range, withNewValue: string)
            return false
        }
        
        return true
    }
}

//MARK: UIImagePickerControllerDelegate
extension NewExpenseViewController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.buttonsContainerView.hidden = true
            self.imageContainerView.hidden = !self.buttonsContainerView.hidden
            self.expenseImageView.image = pickedImage
            self.output.validateForm(self.getCurrentRequestForm())
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: UIPickerViewDelegate
extension NewExpenseViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.projectTextField.isFirstResponder() {
            projectTextField.text = pickerElements[row]
        } else if self.projectCoinTextField.isFirstResponder() {
            projectCoinTextField.text = pickerElements[row]
        } else if self.subjectTextField.isFirstResponder() {
            subjectTextField.text = pickerElements[row]
            self.output.validateExpndCell(subjectTextField.text!)
        }
    }
}

// MARK: UIPickerViewDataSource
extension NewExpenseViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerElements.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerElements[row]
    }
}
