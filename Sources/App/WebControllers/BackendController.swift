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
        routes.get("oxygen-admin", "courses", use: coursesHandler)
        routes.get("oxygen-admin", "add-course", use: createCourseView)
        
        routes.post("oxygen-admin", "learning-guides", use: addLearningGuidePostHandler)
        routes.post("oxygen-admin", "add-course", use: addCoursePostHandler)
        
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
    
    // MARK: Oxygen User Handlers ------------------------------------------------------------------>
    
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
    
    // MARK: Oxygen Learning Guides Handler ---------------------------------------------------------->
    
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
    
    func addLearningGuidePostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
       let input = try req.content.decode(PathContext.self)
        let path = Path(title: input.title)
        return path.save(on: req.db).map { guide in
            return req.redirect(to: "learning-guides")
            
        }
    }
    
  
    
    // MARK: Oxygen Course Handlers ------------------------------------------------------------------>
    
    func coursesHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let title = "\(oxygenTitle) Courses"
        let courses = Course.query(on: req.db).all()
        return courses.flatMap { course in
            let (courses) = course
            let context = CoursesContext(title: title, oxygenVersion: oxygenVersion, devscorchVersion: versionNumber, courses: courses)
            print(courses)
            return req.view.render(coursePage, context)
        }
    }
    
    func createCourseView(_ req: Request) throws -> EventLoopFuture<View> {
        return try! addCourseHandler(req, form: .init())
    }
    
    func beforeRender(_ req: Request, form: CourseForm) -> EventLoopFuture<Void> {
        Path.query(on: req.db).all().mapEach(\.formFieldOption).map { form.pathID.options = $0 }
    }
    
    func addCourseHandler(_ req: Request, form: CourseForm) throws -> EventLoopFuture<View> {
        let title = "\(oxygenTitle) Add a Course"
        let context = AddCourseContext(title: title, oxygenVersion: oxygenVersion, devscorchVersion: versionNumber, edit: form)

        return self.beforeRender(req, form: form).flatMap {
            req.view.render(addCoursePage, context)
        }
    }
    func beforeAddCoursePostHandler(_ req: Request, model: Course, form: CourseForm) -> EventLoopFuture<Course> {
        var future: EventLoopFuture<Course> = req.eventLoop.future(model)
        if let data = form.image.data {
            let key = addCoursePage + UUID().uuidString + "jpg"
            future = req.fs.upload(key: key, data: data).map { url in
                form.image.value = url
                model.imageKey = key
                model.image = url
                return model
            }
        }
        return future
    }
    
    func addCoursePostHandler(_ req: Request) throws -> EventLoopFuture<Response> {
        let form = try CourseForm(req: req)
        return form.validate(req).flatMap { isValid -> EventLoopFuture<Response> in
            guard isValid else {
                return try! self.addCourseHandler(req, form: form).encodeResponse(for: req)
            }
            let model = Course()
            form.writeCourse(to: model)
            return self.beforeAddCoursePostHandler(req, model: model, form: form).flatMap { model in
                return model.create(on: req.db).map { req.redirect(to: coursePage)}
            }
            
            
        }
    }
}


