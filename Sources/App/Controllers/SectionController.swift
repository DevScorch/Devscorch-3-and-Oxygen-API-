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
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Section.find(id, on: req.db).unwrap(or: Abort(.notFound)).map {
            SectionOutPut(id: $0.id!.uuidString, image: $0.image, description: $0.description, title: $0.title, lessons: $0.lessons, course_id: $0.course_id)
        }
    }
    
//    func updateSection(_ req: Request) throws -> EventLoopFuture<SectionOutPut> {
//        
//    }
    
    
}
