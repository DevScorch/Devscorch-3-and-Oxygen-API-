//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import FluentPostgresDriver
import Vapor


final class Student: Model {
    
    struct Public: Content {
      let username: String
      let id: UUID
      let createdAt: Date?
      let updatedAt: Date?
    }
   
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "name")
    var name: String?
    
    @Field(key: "lastname")
    var lastname: String?
    
    @Field(key: "image")
    var image: String?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "stripeID")
    var stripeID: String?
    
    @Field(key: "dateJoined")
    var dateJoined: Date?
    
    @Field(key: "isSubscribed")
    var isSubscribed: Bool?
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    
    init() {}
    
    init(id: UUID? = nil, username: String, password: String, name: String? = nil, lastname: String? = nil, image: String? = nil, email: String, stripeID: String? = nil, dateJoined: Date? = nil, isSubscribed: Bool? = nil) {
        self.id = id
        self.username = username
        self.password = password
        self.name = name
        self.lastname = lastname
        self.image = image
        self.email = email
        self.stripeID = stripeID
        self.isSubscribed = isSubscribed
    }
}

extension Student: Authenticatable {}

extension Student: SessionAuthenticatable {
    typealias SessionID = UUID
    var sessionID: SessionID {
        self.id!
    }
}



extension Student {
    static func create(from userSignUp: UserSignUp) throws -> Student {
        Student(username: userSignUp.username , password: try Bcrypt.hash(userSignUp.password), email: userSignUp.email)
    }
    
    func createToken(source: SessionSource) throws -> Token {
        let calendar = Calendar(identifier: .gregorian)
        let expiryDate = calendar.date(byAdding: .year, value: 1, to: Date())
        return try Token(userId: requireID(), token: [UInt8].random(count: 16).base64, source: source, expiresAt: expiryDate)
    }
    
    func asPublic() throws -> Public {
        Public(username: username, id: try requireID(), createdAt: createdAt, updatedAt: updatedAt)
    }
}

extension Student: ModelAuthenticatable {
    static let usernameKey = \Student.$username
    static let passwordHashKey = \Student.$password
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}


   





