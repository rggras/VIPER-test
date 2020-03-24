//
//  ProjectManager.swift
//  MoneyBack
//
//  Created by Marcelo Perretta  on 5/7/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

private let projectsEndpoint = "/project"

extension NetworkManager {
    func getProjects(success: [Project] -> Void) {
        Alamofire.request(.GET, self.baseUrl + endpoint + projectsEndpoint).responseArray {
            (response: Response<[Project], NSError>) in
            success(response.result.value!)
        }
    }
}
