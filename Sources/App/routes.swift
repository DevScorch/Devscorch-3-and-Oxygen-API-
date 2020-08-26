import Fluent
import Vapor

func routes(_ app: Application) throws {
    let frontendController = FrontendController()
    let userController = UserController()
    let adminController = AdminController()
    let pathController = PathController()
    let courseController = CourseController()
    let backendController = BackendController()
    
    
    try app.register(collection: frontendController)
    try app.register(collection: userController)
    try app.register(collection: adminController)
    try app.register(collection: pathController)
    try app.register(collection: courseController)
    try app.register(collection: backendController)
    
}
