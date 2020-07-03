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
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
    
}

struct LoginContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
}

struct RegisterContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
}

struct LearningGuidesContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool

}

struct CourseContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool

}

struct VideoPlayerContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool

}

struct DiscoverContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool

}

struct ProfileContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct MySubscriptionContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct InvoicesContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct FinishedCoursesContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct NotFoundContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct SuccessFullContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct NotSuccessFullContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct SubscribeContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct TutorialContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct SelectedTutorial: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct ChallengesContext: Codable {
    var title: String
//    let loggedInUser: User?
//    let userLoggedIn: Bool
//    let isSubscried: Bool
}

struct UserSignUp: Content {
    let username: String
    let password: String
    let email: String
}

struct RegisterPostData: Content {
    let username: String
    let password: String
    let email: String
}

struct NewSession: Content {
    let token: String
    let user: Student.Public
}

struct NewAdminSession: Content {
    let token: String
    let admin: Admin.Public
}

struct LoginPostData: Content {
    let username: String
    let password: String
}

