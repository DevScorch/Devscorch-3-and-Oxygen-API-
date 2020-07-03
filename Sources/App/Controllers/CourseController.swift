import Vapor
import Fluent

struct CourseController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let courseRoute = routes.grouped("admin", "courses")
        let protectedCourseRoute = courseRoute.grouped(AdminToken.authenticator())
        
        protectedCourseRoute.post(use: createCourse)
        protectedCourseRoute.get(use: retrieveAllCourses)
        protectedCourseRoute.get(":id", use: retrieveCourse)
        
    }
    
    func createCourse(_ req: Request) throws -> EventLoopFuture<CourseOutput> {
        let input = try req.content.decode(CourseContext.self)
        let course = Course(title: input.title!, description: input.description, lessons: input.lessons, image: input.image, assets: input.assets, path: input.path)
        return course.save(on: req.db).map {CourseOutput(id: course.id!.uuidString, title: course.title, description: course.description, image: course.image, lessons: course.lessons, assets: course.assets)
            
        }
    }
    
    func retrieveAllCourses(_ req: Request) throws -> EventLoopFuture<[Course]> {
        return Course.query(on: req.db).all()
    }
    
    func retrieveCourse(_ req: Request) throws -> EventLoopFuture<CourseOutput> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Course.find(id, on: req.db).unwrap(or: Abort(.notFound)).map {
            CourseOutput(id: $0.id!.uuidString, title: $0.title, description: $0.description, image: $0.image, lessons: $0.lessons, assets: $0.assets)
        }
    }
    
    func updateCourse(_ req: Request) throws -> EventLoopFuture<CourseOutput> {
        guard let id  = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let input = try req.content.decode(Course.self)
        return Course.find(id, on: req.db).unwrap(or: Abort(.notFound)).flatmap { course in
            course.title = input.title
            course.description = input.description
            course.image = input.image
            course.assets = input.assets
            course.lessons = input.lessons
            return course.save(on: req.db)
            
        }
    }
    
}
