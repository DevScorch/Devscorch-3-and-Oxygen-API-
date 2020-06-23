//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent

struct CreateSection: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("sections")
            .field("id", .uuid, .identifier(auto: true))
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("image", .string, .required)
            .field("lessons", .int, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("sections").delete()
    }
}
