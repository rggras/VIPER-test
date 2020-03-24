//
//  Constants.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/18/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import UIKit

struct Constants {

    enum UserDefaults: String {
        case SignInToken = "signInToken",
        ExpirationDate = "expirationDate",
        UserEmail = "userEmail",
        UserAvatar = "userAvatar",
        UserName = "userName"
    }
    
    enum ExpenseConst: String {
        case ARG = "ARG", USD = "USD", EUR = "EUR"
        static let allCoins = [ARG.rawValue, USD.rawValue, EUR.rawValue]
        
        
        case Viaticum = "Viatico y movilidad", Hotel = "Hotel y alojamiento", Food = "Comidas y refrigerios", Others = "Otros"
        static let allConcepts = [Viaticum.rawValue, Hotel.rawValue, Food.rawValue, Others.rawValue]
    }
    
    enum FileConst: String {
        case ErrorMessageFileNumber = "Nro de legajo es requerido",
            SuccessMessageFileNumber = "Nro de legajo guardado!",
            FileNumberKey = "fileNumber",
            GLOUrl = "https://glo.globallogic.com/"
    }
    
    enum NotificationConst: String {
        case DissmissViewController = "kDissmissViewController"
    }
    
    enum ExpenseStatusConst: String {
        case StateIncomplete = "incomplete",
        StatePending = "pending",
        StateApproved = "approved",
        StateDesapproved = "desapproved",
        StateReady = "ready",
        StateClose = "close"
    }
    
    enum Messages: String {
        case Loading = "Cargando",
        Saving = "Guardando"
    }
    
    static let kBaseURLKey = "BaseURLKey"
}
