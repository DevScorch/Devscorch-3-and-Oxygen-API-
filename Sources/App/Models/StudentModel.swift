//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import FluentPostgresDriver
import Vapor


final class Student: Model, Content {
   
    
    static let schema = "students"
    
    @ID(key: "id")
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
    
    
    init() {}
    
    init(id: UUID, username: String, password: String, name: String, lastname: String, image: String, email: String, stripeID: String, dateJoined: Date, isSubscribed: Bool) {
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

extension Student: SessionAuthenticatable {
    var sessionID: String {
        self.username
    }
}



