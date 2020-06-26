import Fluent
import Vapor

func routes(_ app: Application) throws {
    let websiteController = WebsiteController()
    let userController = UserController()
    
    
    try app.register(collection: websiteController)
    try app.register(collection: userController)
}
