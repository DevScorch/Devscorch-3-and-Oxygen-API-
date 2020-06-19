//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent

struct CreateStudent: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("students")
        .id()
            .field("username", .string, .required)
        .field("password", .string, .required)
        .field("name", .string)
        .field("lastname", .string)
        .field("image", .string)
        .field("email", .string, .required)
        .field("stripeID", .string, .required)
        .field("dateJoined", .date, .required)
        .field("isSubscribed", .bool, .required)
        .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("students").delete()
    }
    
}
