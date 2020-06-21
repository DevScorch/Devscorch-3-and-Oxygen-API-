//
//  File.swift
//  
//
//  Created by Johan on 19/06/2020.
//

import Vapor
import Fluent


struct IndexContext: Codable {
    var title: String
    
}

struct LoginContext: Codable {
    var title: String
}

struct RegisterContext: Codable {
    var title: String
}

struct LearningGuidesContext: Codable {
    var title: String
}

