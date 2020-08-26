//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import FluentPostgresDriver

struct CreateCourse: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("courses")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("lessons", .int, .required)
            .field("image", .string, .required)
            .field("assets", .string, .required)
            .field("path_id", .uuid, .references("paths", "id"))
            .field("createdAt", .date)
            .field("updatedAt", .date)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("courses").delete()
    }
}
