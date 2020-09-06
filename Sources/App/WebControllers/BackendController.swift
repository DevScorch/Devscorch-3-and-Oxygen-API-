//
//  File.swift
//
//
//  Created by Johan on 09/08/2020.
//

import Foundation
import Vapor
import Leaf

struct BackendController: RouteCollection{
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("oxygen-admin", use: indexHandler)
        routes.get("oxygen-admin", "users", use: userPageHandler)
        routes.get("oxygen-admin", "learning-guides", use: learningGuidesHandler)
        routes.get("oxygen-admin", "add-learning-guide", use: addLearningGuideHandler)
        
        routes.post("oxygen-admin", "add-learning-guide", use: addLearningGuidePostHandler)
    }
    
    
    // MAR: Backend Index Handler
    
    func indexHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let title = "\(oxygenTitle) Dashboard"
        let students = Student.query(on: req.db).count()
        let videos = Lesson.query(on: req.db).count()
        let courses = Course.query(on: req.db).count()
        let learningGuides = Path.query(on: req.db).count()
        
        let oxygenversion = oxygenVersion
        let devscorchVersion = versionNumber
        
        return students.and(videos).and(courses).and(learningGuides).flatMap { values in
            let (((students, videos), courses), learningGuides) = values
            let context = DashboardContext(title: title, oxygenVersion: oxygenversion, devscorchVersion: devscorchVersion, users: students, courses: courses, videos: videos, guides: learningGuides)
            return req.view.render(adminIndex, context)
        }
    }
    
    func userPageHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let title = "\(oxygenTitle) Users"
        let url = userIndex
        let students = Student.query(on: req.db).all()
        
        return students.flatMap { student in
            let (students) = student
            let context = UserPageContext(title: title, url: url, oxygenVersion: oxygenVersion, devscorchVersion: versionNumber, users: students)
            print(students)
            
            return req.view.render(userIndex, context)
            
        }
    }
    
    func learningGuidesHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let title = "\(oxygenTitle) Learning Guides"
        let guides = Path.query(on: req.db).all()
        let body = "body"
        
        return guides.flatMap { guide in
            let (guides) = guide
            let context = LearningGuideContext(title: title, oxygenVersion: oxygenVersion, devscorchVersion: versionNumber, guides: guides, body: body)
            print(guides)
            
            return req.view.render(learningGuide, context)
        }
    }
    
    func addLearningGuideHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let title = "\(oxygenTitle) Add Learning Guide"
        let context = AddLearningGuideContext(title: title, oxygenVersion: oxygenVersion, devscorchVersion: versionNumber)
        return req.view.render(addLearningGuide, context)
    }
    
    func addLearningGuidePostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let guide = Path()
        
        return guide.save(on: req.db).map { guide in
            return req.redirect(to: learningGuide)
        }
    }
}


