//
//  File.swift
//  
//
//  Created by Johan on 19/06/2020.
//

import Vapor
import Leaf
import Fluent

struct WebsiteController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
            
        //MARK: Authentication routes
        let protectedRoute = authSessionRoute.grouped(User.redirectMiddleware(path: "/login"))
        let tokenProtected = routes.grouped(Token.authenticator())
        let passwordProtected = routes.grouped(User.authenticator())
        
        routes.get(use: indexHandler)
        routes.get("login", use: loginHandler)
        routes.get("register", use: registerHandler)
        routes.get("learning-guides", use: learningGuidesHandler)
        
    }
    
    func indexHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = IndexContext(title: "\(title) Home")
        return req.view.render("oxygen-web/index", context)
    }
    
    func loginHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = LoginContext(title: "\(title) Login")
        return req.view.render(loginURL, context)
    }
    
    
    func registerHandler(_ req:Request) throws -> EventLoopFuture<View> {
        let context = RegisterContext(title: "\(title) Register")
        return req.view.render(registerURL, context)
    }
    
    func learningGuidesHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = LearningGuidesContext(title: "\(title) Learning Guides")
        return req.view.render(guidedLearningURL, context)
    }
    
//    func selectedCourseHandler(_ req: Request) throws -> EventLoopFuture<View> {
//        
//    }
    
}
