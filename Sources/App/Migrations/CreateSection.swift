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
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("image", .string, .required)
            .field("lessons", .int, .required)
            .field("course_id", .uuid, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("sections").delete()
    }
}
