//
//  FileNumberViewController.swift
//  MoneyBack
//
//  Created by Gerson Villanueva Faillace on 4/28/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit
import Common

protocol FileNumberViewControllerInput {
    func navigateToHome(isEditing: Bool)
    func openGLOInSafari()
    func displaySuccessOrErrorMessage(message: String)
    func displayFileNumber(value: String)
}

protocol FileNumberViewControllerOutput {
    func saveFileNumber(fileNumber: String?, isEditing: Bool)
    func getFileNumber()
}

class FileNumberViewController: UIViewController, FileNumberViewControllerInput, BaseViewController {
    var output: FileNumberViewControllerOutput!
    var router: FileNumberRouter!
  
    @IBOutlet weak var fileNumberTextField: UITextField!
    @IBOutlet weak var editFileNumberTextField: UITextField!
    
    // MARK: Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.getFileNumber()
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        FileNumberConfigurator.sharedInstance.configure(self)
    }
  
    // MARK: Display logic
    func navigateToHome(isEditing: Bool) {
        if isEditing {
            NSNotificationCenter.defaultCenter().postNotificationName(Constants.NotificationConst.DissmissViewController.rawValue, object: nil, userInfo: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            self.router.navigateToHome()
        }
    }
    
    func openGLOInSafari() {
        self.router.openGLOInSafari()
    }
    
    func displaySuccessOrErrorMessage(message: String) {
        self.router.showErrorMessage(message, viewController: self)
    }
    
    func displayFileNumber(value: String) {
        guard self.editFileNumberTextField != nil else { return }
        self.editFileNumberTextField.text = value
    }
    
    // MARK: IBAction
    @IBAction func gloButtonTapped(sender: AnyObject) {
        openGLOInSafari()
    }
    
    @IBAction func skipButtonTapped(sender: AnyObject) {
        navigateToHome(true)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        output.saveFileNumber(fileNumberTextField.text, isEditing: false)
    }
    
    @IBAction func updateButtonTapped(sender: AnyObject) {
        output.saveFileNumber(fileNumberTextField.text, isEditing: true)
    }
    
    // MARK: - UITapGestureRecognizer
    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
}
