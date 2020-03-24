//
//  ProfileModels.swift
//  MoneyBack
//
//  Created by Rodrigo Gras on 4/20/16.
//  Copyright (c) 2016 Globallogic. All rights reserved.
//

import UIKit

struct ProfileRequest {}

struct ProfileResponse {
    var avatarUrl: String?
    var name: String?
    var email: String?
}

struct ProfileViewModel {
    var avatarUrl: String?
    var name: String?
    var email: String?
}
