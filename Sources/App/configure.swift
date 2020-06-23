import Fluent
import FluentPostgresDriver
import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) throws {
    
    // MARK: CORS MiddleWare
    
     let corsConfiguration = CORSMiddleware.Configuration(allowedOrigin: .all, allowedMethods: [.POST, .GET, .PUT, .OPTIONS, .DELETE, .PATCH], allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin])
     let corsMiddleWare = CORSMiddleware(configuration: corsConfiguration)
     
    // MARK: Middlewares
    
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
     app.middleware.use(corsMiddleWare)
    
    // MARK: Configure leaf
    
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease

    app.databases.use(.postgres(
        hostname: Environment.get("localhost") ?? "localhost",
        username: Environment.get("vapor") ?? "vapor",
        password: Environment.get("password") ?? "password",
        database: Environment.get("postgres") ?? "postgres"
    ), as: .psql)

    app.migrations.add(CreateAdmin())
    app.migrations.add(CreateCourse())
    app.migrations.add(CreateCourse())
    app.migrations.add(CreateLesson())
    app.migrations.add(CreatePath())
    app.migrations.add(CreateSection())
    app.migrations.add(CreateStudent())
    app.migrations.add(CreateToken())
    app.migrations.add(CreateTutorial())
    
    

    // register routes
    try routes(app)
    
    
}
