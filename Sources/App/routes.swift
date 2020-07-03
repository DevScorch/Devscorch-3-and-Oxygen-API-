import Fluent
import Vapor

func routes(_ app: Application) throws {
    let websiteController = WebsiteController()
    let userController = UserController()
    let adminController = AdminController()
    let pathController = PathController()
    
    
    try app.register(collection: websiteController)
    try app.register(collection: userController)
    try app.register(collection: adminController)
    try app.register(collection: pathController)
    
}
