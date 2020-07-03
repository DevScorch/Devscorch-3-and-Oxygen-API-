//
//  File.swift
//  
//
//  Created by Johan on 19/06/2020.
//

import Vapor
import Fluent

struct AdminSignUp: Content {
    let username: String
    let password: String
    let email: String
}

struct PathContext: Content {
    let title: String
}

struct PathOutput: Content {
    let id: String
    let title: String
}



