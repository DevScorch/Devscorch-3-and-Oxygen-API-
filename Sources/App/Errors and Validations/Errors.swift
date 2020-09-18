
//
//  File.swift
//  
//
//  Created by Johan on 22/06/2020.
//

import Vapor

enum UserError {
  case usernameTaken
}

enum CourseError {
    case titleIsEmpty
    case lessonsIsEmpty
    case descriptionIsEmpty
    case imageIsEmpty
    case assetsIsEmpty
    case pathIsEmpty
}


extension UserError: AbortError {
  var description: String {
    reason
  }

  var status: HTTPResponseStatus {
    switch self {
    case .usernameTaken: return .conflict
    }
  }

  var reason: String {
    switch self {
    case .usernameTaken: return "Username already taken"
    }
  }
}

extension CourseError {
    var description: String {
        reason
    }
    
    var status: HTTPResponseStatus {
        switch self {
        case .assetsIsEmpty: return .conflict
        case .descriptionIsEmpty: return .conflict
        case .imageIsEmpty: return .conflict
        case .titleIsEmpty: return .conflict
        case .pathIsEmpty: return .conflict
        case .lessonsIsEmpty: return .conflict
        }
    }
    
    var reason: String {
        switch self {
        case .assetsIsEmpty: return "You forgot to add your assets :("
        case .descriptionIsEmpty: return "You forgot to add a description :("
        case .imageIsEmpty: return "You forgot to add a image"
        case .titleIsEmpty: return "You forgor to add a title :("
        case .pathIsEmpty: return "You forgot to add a Learning Guide :("
        case .lessonsIsEmpty: return "You forgot to add the amount of lessons :("
        }
    }
}
