//
//  Project.swift
//  MoneyBack
//
//  Created by Marcelo Perretta  on 4/28/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

import ObjectMapper

class Project: Mappable {
    
    var projectId: String?
    var name: String?
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        
        projectId <- map["id"]
        name <- map["name"]
    }


}
