//
//  UserDefaultsWorker.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/18/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

//TODO manejar como un singleton si es el caso, renombrar la clase, usar NSCoding para serializar y deserializar los objetos que se quieren guardar
class UserDefaultsWorker {
    let defaults = NSUserDefaults.standardUserDefaults()

    // MARK: Business Logic

    func saveUser(user: User) {
        self.defaults.setObject(user.idToken, forKey: Constants.UserDefaults.SignInToken.rawValue)
        self.defaults.setObject(user.expirationDate, forKey: Constants.UserDefaults.ExpirationDate.rawValue)
        self.defaults.setObject(user.name, forKey: Constants.UserDefaults.UserName.rawValue)
        self.defaults.setObject(user.email, forKey: Constants.UserDefaults.UserEmail.rawValue)
        self.defaults.setObject(user.profileURL, forKey: Constants.UserDefaults.UserAvatar.rawValue)
    }

    func getUser() -> User {
        return User(
            userId: String(),
            idToken: defaults.objectForKey(Constants.UserDefaults.SignInToken.rawValue) as? String ?? String(),
            expirationDate: defaults.objectForKey(Constants.UserDefaults.ExpirationDate.rawValue) as? NSDate ?? NSDate(timeIntervalSince1970: 0),
            name: defaults.objectForKey(Constants.UserDefaults.UserName.rawValue) as? String ?? String(),
            email: defaults.objectForKey(Constants.UserDefaults.UserEmail.rawValue) as? String ?? String(),
            profileURL: defaults.objectForKey(Constants.UserDefaults.UserAvatar.rawValue) as? String ?? String())
    }
    
    func removeUser() {
        self.defaults.removeObjectForKey(Constants.UserDefaults.SignInToken.rawValue)
        self.defaults.removeObjectForKey(Constants.UserDefaults.ExpirationDate.rawValue)
        self.defaults.removeObjectForKey(Constants.UserDefaults.UserName.rawValue)
        self.defaults.removeObjectForKey(Constants.UserDefaults.UserEmail.rawValue)
        self.defaults.removeObjectForKey(Constants.UserDefaults.UserAvatar.rawValue)
    }
    
    func saveFileNumber(fileNumber: String?) {
        self.defaults.setObject(fileNumber, forKey: Constants.FileConst.FileNumberKey.rawValue)
    }
    
    func getFileNumber() -> String {
        return defaults.objectForKey(Constants.FileConst.FileNumberKey.rawValue) as? String ?? String()
    }
}
