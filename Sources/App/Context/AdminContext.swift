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

struct CourseContext: Content {
    let id: String
    let title: String?
    let description: String
    let image: String
    let lessons: Int
    let assets: String
    let path: Path
}

struct CourseOutput: Content {
    let id: String
    let title: String
    let description: String
    let image: String
    let lessons: Int
    let assets: String
}



