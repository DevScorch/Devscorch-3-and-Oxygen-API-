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

struct CoursePostContext: Decodable {
    let id: String? = nil
    let title: String
    let description: String
    let image: File?
    let lessons: Int
    let assets: String
    let pathID: String
    let imageDelete: Bool?
}

struct CourseOutput: Content {
    let id: String
    let title: String
    let description: String
    let image: String
    let lessons: Int
    let assets: String
    let path: Path
}

struct SectionContext: Content {
    let image: String
    let description: String
    let title: String
    let lessons: Int
    let course_id: Course
}

struct SectionOutPut: Content {
    let id: String
    let image: String
    let description: String
    let title: String
    let lessons: Int
    let course_id: Course
}





