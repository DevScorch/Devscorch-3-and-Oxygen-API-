import Vapor
import Fluent

struct UserController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let usersRoute = routes.grouped("users")
    usersRoute.post("signup", use: create)
    
    let tokenProtected = usersRoute.grouped(Token.authenticator())
    tokenProtected.get("me", use: getMyOwnUser)
    
    let passwordProtected = usersRoute.grouped(Student.authenticator())
    passwordProtected.post("login", use: login)
  }

  fileprivate func create(req: Request) throws -> EventLoopFuture<NewSession> {
    try UserSignUp.validate(req)
    let userSignup = try req.content.decode(UserSignUp.self)
    let user = try Student.create(from: userSignup)
    var token: Token!

    return checkIfUserExists(userSignup.username, req: req).flatMap { exists in
      guard !exists else {
        return req.eventLoop.future(error: UserError.usernameTaken)
      }

      return user.save(on: req.db)
    }.flatMap {
      guard let newToken = try? user.createToken(source: .signup) else {
        return req.eventLoop.future(error: Abort(.internalServerError))
      }
      token = newToken
      return token.save(on: req.db)
    }.flatMapThrowing {
      NewSession(token: token.value, user: try user.asPublic())
    }
  }

  fileprivate func login(req: Request) throws -> EventLoopFuture<NewSession> {
    let user = try req.auth.require(Student.self)
    let token = try user.createToken(source: .login)

    return token.save(on: req.db).flatMapThrowing {
      NewSession(token: token.value, user: try user.asPublic())
    }
  }

  func getMyOwnUser(req: Request) throws -> Student.Public {
    try req.auth.require(Student.self).asPublic()
  }

  private func checkIfUserExists(_ username: String, req: Request) -> EventLoopFuture<Bool> {
    Student.query(on: req.db)
      .filter(\.$username == username)
      .first()
      .map { $0 != nil }
  }
}






