import Vapor
import Fluent


struct PathController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let pathRoute = routes.grouped("admin", "paths")
        let protectedPathRoute = pathRoute.grouped(AdminToken.authenticator())
        
        protectedPathRoute.post(use: createPath)
        protectedPathRoute.get(use: retrieveAllPaths)
        protectedPathRoute.get(":id", use: retrievePath)
        protectedPathRoute.post(":id", use: updatePath)
        protectedPathRoute.delete(":id", use: deletePath)
        
    }
    
    func createPath(_ req: Request) throws -> EventLoopFuture<PathOutput> {
        let input = try req.content.decode(PathContext.self)
        let path = Path(title: input.title)
        return path.save(on: req.db).map { PathOutput(id: path.id!.uuidString, title: path.title)
            
        }
    }
    
    func retrieveAllPaths(_ req: Request) throws -> EventLoopFuture<[Path]> {
        return Path.query(on: req.db).all()
    }
    
    func retrievePath(_ req: Request) throws -> EventLoopFuture<PathOutput> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Path.find(id, on: req.db).unwrap(or: Abort(.notFound)).map {PathOutput(id: $0.id!.uuidString, title: $0.title)
        }
    }
    
    func updatePath(_ req: Request) throws -> EventLoopFuture<PathOutput> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let input = try req.content.decode(Path.self)
        return Path.find(id, on: req.db).unwrap(or: Abort(.notFound)).flatMap { path in
            path.title = input.title
            return path.save(on: req.db).map {PathOutput(id: path.id!.uuidString, title: path.title)}
        }
    }
    
    func deletePath(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let id = req.parameters.get(":id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Path.find(id, on: req.db).unwrap(or: Abort(.notFound)).flatMap {$0.delete(on: req.db)}.map {.ok}
    }
}
