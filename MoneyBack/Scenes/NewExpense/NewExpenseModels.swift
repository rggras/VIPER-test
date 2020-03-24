//
//  NewExpenseModels.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 3/31/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

struct NewExpenseRequest {
    var projectName: String?
    var date: String?
    var docketNumber: String?
    var subject: String?
    var ticketNumber: String?
    var amount: String?
    var coin: String?
    var attachedImage: UIImage?
    var status: String?
}

struct NewExpenseResponse {}

struct NewExpenseViewModel {}


struct NewExpenseProjectsResponse {
    var projects: [Project]
}
