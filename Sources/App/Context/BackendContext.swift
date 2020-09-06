//
//  File.swift
//  
//
//  Created by Johan on 26/08/2020.
//

import Vapor
import Leaf

struct DashboardContext: Content {
    let title: String
    let oxygenVersion: Double
    let devscorchVersion: Double
    let users: Int
    let courses: Int
    let videos: Int
    let guides: Int
    
    init(title: String, oxygenVersion: Double, devscorchVersion: Double, users: Int, courses: Int, videos: Int, guides: Int) {
        self.title = title
        self.oxygenVersion = oxygenVersion
        self.devscorchVersion = devscorchVersion
        self.users = users
        self.courses = courses
        self.videos = videos
        self.guides = guides
    }
}

struct UserPageContext: Content {
    let title: String
    let url: String
    let oxygenVersion: Double
    let devscorchVersion: Double
    let users: [Student]
    
}

struct LearningGuideContext: Content {
    let title: String
    let oxygenVersion: Double
    let devscorchVersion: Double
    let guides: [Path]
    let body: String
}

struct AddLearningGuideContext: Content {
    let title: String
    let oxygenVersion: Double
    let devscorchVersion: Double
}

struct AddLearningGuideData: Content {
    var title: String
}

struct CoursesContext: Content {
    let title: String
    let oxygenVersion: Double
    let devscorchVersion: Double
    let courses: [Course]
}

struct AddCourseContext: Content {
    let title: String
    let oxygenVersion: Double
    let devscorchVersion: Double
    let courseTitle: String
    let description: String
    let lessons: Int
    let image: String
    let assets: String
    let path: Path.IDValue
    let createdAt: Date?
}




