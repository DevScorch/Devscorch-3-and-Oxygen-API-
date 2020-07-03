//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import Vapor
import FluentPostgresDriver


final class Admin: Model {
    
    struct Public: Content {
      let username: String
      let id: UUID
      let createdAt: Date?
      let updatedAt: Date?
    }
   
    
    static let schema = "admins"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "name")
    var name: String?
    
    @Field(key: "lastName")
    var lastName: String?
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "image")
    var image: String?
    
    @Field(key: "description")
    var description: String?
    
    @Field(key: "githubURL")
    var githubURL: String?
    
    @Field(key: "linkedInURL")
    var linkedInURL: String?
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    @Field(key: "email")
    var email: String
    
    init() {}
    
    init(id: UUID? = nil, username: String, name: String? = nil, lastName: String? = nil, password: String, image: String? = nil, description: String? = nil, githubURL: String? = nil, linkedInURL: String? = nil, email: String) {
        self.id = id
        self.username = username
        self.name = name
        self.lastName = lastName
        self.password = password
        self.image = image
        self.description = description
        self.githubURL = githubURL
        self.linkedInURL = linkedInURL
        self.email = email
    }
}

extension Admin: Authenticatable {}

extension Admin: SessionAuthenticatable {
    typealias SessionID = UUID
    var sessionID: SessionID {
        self.id!
    }
}

extension Admin {
    static func create(from adminSignUp: AdminSignUp) throws -> Admin {
        Admin(username: adminSignUp.username , password: try Bcrypt.hash(adminSignUp.password), email: adminSignUp.email)
    }
    
    func createToken(source: AdminSessionSource) throws -> AdminToken {
        let calendar = Calendar(identifier: .gregorian)
        let expiryDate = calendar.date(byAdding: .year, value: 1, to: Date())
        return try AdminToken(adminId: requireID(), token: [UInt8].random(count: 16).base64, source: source, expiresAt: expiryDate)
    }
    
    func asPublic() throws -> Public {
        Public(username: username, id: try requireID(), createdAt: createdAt, updatedAt: updatedAt)
    }
}

extension Admin: ModelAuthenticatable {
    static let usernameKey = \Admin.$username
    static let passwordHashKey = \Admin.$password
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}


   







