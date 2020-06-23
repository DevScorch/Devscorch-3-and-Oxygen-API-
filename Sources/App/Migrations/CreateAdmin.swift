//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import FluentPostgresDriver


struct CreateAdmin: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("admins")
            .field("id", .uuid, .identifier(auto: true))
            .field("username", .string, .required).unique(on: "username")
            .field("name", .string, .required)
            .field("lastName", .string)
            .field("password", .string, .required)
            .field("image", .string)
            .field("description", .string)
            .field("githubURL", .string)
            .field("linkedInURL", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("admins").delete()
    }
    
}
