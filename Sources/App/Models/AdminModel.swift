//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import Vapor
import FluentPostgresDriver


final class Admin: Model, Content {
    static let schema = "admins"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "lastName")
    var lastName: String
    
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
    
    init() {}
    
    init(id: UUID?, username: String, name: String, lastName: String, password: String, image: String, description: String, githubURL: String, linkedInURL: String) {
        self.id = id
        self.username = username
        self.name = name
        self.lastName = lastName
        self.password = password
        self.image = image
        self.description = description
        self.githubURL = githubURL
        self.linkedInURL = linkedInURL
    }
}
