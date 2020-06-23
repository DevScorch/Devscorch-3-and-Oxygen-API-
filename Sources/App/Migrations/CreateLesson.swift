//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent

struct CreateLesson: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("lessons")
            .field("id", .uuid, .identifier(auto: true))
            .field("title", .string, .required)
            .field("duration", .string, .required)
            .field("number", .int)
            .create()
        
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("lessons").delete()
    }
}
