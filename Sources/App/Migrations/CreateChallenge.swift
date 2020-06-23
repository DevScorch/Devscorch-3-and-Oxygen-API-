//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import FluentPostgresDriver

struct CreateChallenge: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("challenges")
            .field("id", .uuid, .identifier(auto: true))
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("downloadURL", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("challenges").delete()
    }
}
