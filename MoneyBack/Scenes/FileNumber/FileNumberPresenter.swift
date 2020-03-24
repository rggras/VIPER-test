//
//  FileNumberPresenter.swift
//  MoneyBack
//
//  Created by Gerson Villanueva Faillace on 4/28/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol FileNumberPresenterInput {
    func presentSuccessOrErrorMessage(success: Bool, isEditing: Bool)
    func presentFileNumber(value: String)
}

protocol FileNumberPresenterOutput: class {
    func displaySuccessOrErrorMessage(message: String)
    func navigateToHome(goToMain: Bool)
    func displayFileNumber(value: String)
}

class FileNumberPresenter: FileNumberPresenterInput {
    weak var output: FileNumberPresenterOutput!
    
    func presentSuccessOrErrorMessage(success: Bool, isEditing: Bool) {
        if success {
            output.navigateToHome(isEditing)
        } else {
            output.displaySuccessOrErrorMessage(Constants.FileConst.ErrorMessageFileNumber.rawValue)
        }
    }
    
    func presentFileNumber(value: String) {
        if value.isEmpty {
            return output.displayFileNumber("No value")
        }
        return output.displayFileNumber(value)
    }
  
}
