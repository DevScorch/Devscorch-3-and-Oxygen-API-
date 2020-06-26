//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent

struct CreateUser: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users")
            .id()
            .field("username", .string, .required)
        .field("password", .string, .required)
        .field("name", .string)
        .field("lastname", .string)
        .field("image", .string)
        .field("email", .string, .required)
        .field("stripeID", .string)
        .field("dateJoined", .date)
        .field("isSubscribed", .bool)
        .field("createdAt", .datetime, .required)
        .field("updatedAt", .datetime, .required)
        .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users").delete()
    }
    
}
