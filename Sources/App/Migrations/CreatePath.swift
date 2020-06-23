//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent

struct CreatePath: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("paths")
            .field("id", .uuid, .identifier(auto: true))
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("paths").delete()        
    }
    
}
