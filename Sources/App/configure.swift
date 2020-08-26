import Fluent
import FluentPostgresDriver
import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) throws {
    
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    encoder.dateEncodingStrategy = .iso8601
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601
    
    // MARK: CORS MiddleWare
    
     let corsConfiguration = CORSMiddleware.Configuration(allowedOrigin: .all, allowedMethods: [.POST, .GET, .PUT, .OPTIONS, .DELETE, .PATCH], allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin])
     let corsMiddleWare = CORSMiddleware(configuration: corsConfiguration)
     
    // MARK: Middlewares
    
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
     app.middleware.use(corsMiddleWare)
    app.middleware.use(ErrorMiddleware.default(environment: app.environment))
    app.middleware.use(app.sessions.middleware)
    
    
    // MARK: Configure leaf
    
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease

    app.databases.use(.postgres(
        hostname: "localhost",
        username: "vapor",
        password: "password",
        database: "postgres"
    ), as: .psql)
    
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)

    app.migrations.add(CreateAdmin())
    app.migrations.add(CreatePath())
    app.migrations.add(CreateAdminToken())
    app.migrations.add(CreateCourse())
    app.migrations.add(CreateLesson())
    app.migrations.add(CreateSection())
    app.migrations.add(CreateUser())
    app.migrations.add(CreateToken())
    app.migrations.add(CreateTutorial())
    
    // register routes
    try routes(app)
    
    
}
