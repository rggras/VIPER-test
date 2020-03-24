//
//  FileNumberWorker.swift
//  MoneyBack
//
//  Created by Gerson Villanueva Faillace on 4/28/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

class FileNumberWorker {
    // MARK: Business Logic
  
    func saveFileNumber(fileNumber: String?) {
        let userDefaultWorker = UserDefaultsWorker()
        userDefaultWorker.saveFileNumber(fileNumber)
    }
}
