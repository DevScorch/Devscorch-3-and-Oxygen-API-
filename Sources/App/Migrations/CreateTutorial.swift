//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent

struct CreateTutorial: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("tutorials")
            .field("id", .uuid, .identifier(auto: true))
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("downloadURL", .string, .required)
        .create()
        
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("tutorials").delete()
    }
    
}
