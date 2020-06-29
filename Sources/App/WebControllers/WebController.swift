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
        let protectedRoute = routes.grouped(User.redirectMiddleware(path: "/login"))
        let tokenProtected = routes.grouped(Token.authenticator())
        let passwordProtected = routes.grouped(User.authenticator())
        
        routes.get(use: indexHandler)
        routes.get("login", use: loginHandler)
        routes.get("register", use: registerHandler)
        routes.get("learning-guides", use: learningGuidesHandler)
        routes.get("learning-guides", "course", use: selectedCourseHandler)
        routes.get("learning-guides", "courses", "videoplayer", use: videoPlayerHandler)
        
    }
    
    func indexHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let userLoggedIn = try req.auth.has(User.self)
        let loggedInUser = try req.auth.get(User.self)
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
    
    func selectedCourseHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = CourseContext(title: "\(title) Course")
        return req.view.render(selectedCourseURL, context)
    }
    
    func videoPlayerHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = VideoPlayerContext(title: "\(title) Videoplayer")
        return req.view.render(getStartedURL, context)
    }
    
    func discoverHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = DiscoverContext(title: "\(title) Discover")
        return req.view.render("discover")
    }
    
    func tutorialHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = TutorialContext(title: "\(title) Tutorial")
        return req.view.render("tutorial", context)
    }
    
    func challengeHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = ChallengesContext(title: "\(title) Challenges")
        return req.view.render("challenges", context)
    }
    
    func profileHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = ProfileContext(title: "\(title) Profile")
        return req.view.render("profile", context)
    }
    
    func mySubscriptionHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = MySubscriptionContext(title: "\(title) My Subscription")
        return req.view.render("my-subscription", context)
    }
    
    
    
}
