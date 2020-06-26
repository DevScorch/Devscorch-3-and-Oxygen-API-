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

struct SelectedGuideContext: Codable {
    var title: String
}

struct VideoPlayerContext: Codable {
    var title: String
}

struct DiscoverContext: Codable {
    var title: String
}


struct UserSignUp: Content {
    let username: String
    let password: String
    let email: String
}

struct NewSession: Content {
    let token: String
    let user: User.Public
}

