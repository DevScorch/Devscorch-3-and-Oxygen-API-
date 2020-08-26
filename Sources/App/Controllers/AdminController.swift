import Vapor
import Leaf
import FluentPostgresDriver

struct AdminController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let adminRoute = routes.grouped("admin")
        adminRoute.post("signup", use: create)
        
        let tokenProtected = adminRoute.grouped(AdminToken.authenticator())
        tokenProtected.get("me", use: getMyOwnUser)
        
        let passwordProtected = adminRoute.grouped(Admin.authenticator())
        passwordProtected.post("login", use: login)
        
    }
    
    fileprivate func create(req: Request) throws -> EventLoopFuture<NewAdminSession> {
        try AdminSignUp.validate(content: req)
      let adminSignup = try req.content.decode(AdminSignUp.self)
      let admin = try Admin.create(from: adminSignup)
      var token: AdminToken!

      return checkIfUserExists(adminSignup.username, req: req).flatMap { exists in
        guard !exists else {
          return req.eventLoop.future(error: UserError.usernameTaken)
        }

        return admin.save(on: req.db)
      }.flatMap {
        guard let newToken = try? admin.createToken(source: .signup) else {
          return req.eventLoop.future(error: Abort(.internalServerError))
        }
        token = newToken
        return token.save(on: req.db)
      }.flatMapThrowing {
        NewAdminSession(token: token.value, admin: try admin.asPublic())
      }
    }

    fileprivate func login(req: Request) throws -> EventLoopFuture<NewAdminSession> {
      let admin = try req.auth.require(Admin.self)
      let token = try admin.createToken(source: .login)

      return token.save(on: req.db).flatMapThrowing {
        NewAdminSession(token: token.value, admin: try admin.asPublic())
      }
    }

    func getMyOwnUser(req: Request) throws -> Admin.Public {
      try req.auth.require(Admin.self).asPublic()
    }

    private func checkIfUserExists(_ username: String, req: Request) -> EventLoopFuture<Bool> {
      Admin.query(on: req.db)
        .filter(\.$username == username)
        .first()
        .map { $0 != nil }
    }
    

}

