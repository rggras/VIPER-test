//
//  FileNumberInteractor.swift
//  MoneyBack
//
//  Created by Gerson Villanueva Faillace on 4/28/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

protocol FileNumberInteractorInput {
    func saveFileNumber(fileNumber: String?, isEditing: Bool)
    func getFileNumber()
}

protocol FileNumberInteractorOutput {
    func presentSuccessOrErrorMessage(success: Bool, isEditing: Bool)
    func presentFileNumber(value: String)
}

class FileNumberInteractor: FileNumberInteractorInput {
    var output: FileNumberInteractorOutput!
    var worker: FileNumberWorker!
  
    // MARK: Business logic
    func saveFileNumber(fileNumber: String?, isEditing: Bool) {
        if fileNumber!.isEmpty {
            self.output.presentSuccessOrErrorMessage(false, isEditing: isEditing)
        } else {
            worker = FileNumberWorker()
            worker.saveFileNumber(fileNumber)
            self.output.presentSuccessOrErrorMessage(true, isEditing: isEditing)
        }
    }
    
    func getFileNumber() {
        let userDefaultworker = UserDefaultsWorker()
        self.output.presentFileNumber(userDefaultworker.getFileNumber())
    }
}
