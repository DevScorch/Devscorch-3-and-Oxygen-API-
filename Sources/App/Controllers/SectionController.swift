import Vapor
import Fluent

struct SectionController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let pathRoute = routes.grouped("admin", "sections")
        let protectedPathRoute = pathRoute.grouped(AdminToken.authenticator())
    }
    
    func createSection(_ req: Request) throws -> EventLoopFuture<SectionOutPut> {
        let input = try req.content.decode(SectionContext.self)
        let section = Section(title: input.title, description: input.description, image: input.image, lessons: input.lessons, course_id: input.course_id)
        return section.save(on: req.db).map {SectionOutPut(id: section.id!.uuidString, image: section.image, description: section.description, title: section.title, lessons: section.lessons, course_id: section.course_id)}
    }
    
    func retrieveAllSection(_ req: Request) throws -> EventLoopFuture<[Section]> {
        return Section.query(on: req.db).all()
    }
    
    func retrieveSection(_ req: Request) throws -> EventLoopFuture<SectionOutPut> {
        
    }
    
    
}
