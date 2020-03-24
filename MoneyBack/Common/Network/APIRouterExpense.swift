//
//  ExpenseAPIRouter.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 5/9/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouterExpense: URLRequestConvertible {
    static let baseURLString = NSBundle.mainBundle().objectForInfoDictionaryKey("BaseURLKey") as? String
    
    case CreateExpense([String: AnyObject])
    case ReadExpenses()
    case UpdateExpense([String: AnyObject])
    case DeleteExpense(NSInteger)
    
    var method: Alamofire.Method {
        switch self {
        case .CreateExpense:
            return .POST
        case .ReadExpenses:
            return .GET
        case .UpdateExpense:
            return .PUT
        case .DeleteExpense:
            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .CreateExpense:
            return "/me/request/spend"
        case .ReadExpenses:
            return "/me/request/spend"
        case .UpdateExpense(let parameters):
            return "/me/request/spend/\(parameters["expenseId"])"
        case .DeleteExpense(let expenseId):
            return "/me/request/spend/\(expenseId)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    // swiftlint:disable variable_name
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: APIRouterExpense.baseURLString!)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
 
        switch self {
        case .CreateExpense(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .UpdateExpense(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}
