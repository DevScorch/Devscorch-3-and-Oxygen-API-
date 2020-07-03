//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import FluentPostgresDriver
import Vapor

final class Path: Model, Content {
    static let schema = "paths"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
  
    
    init() {}
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
    
}

extension Path {
    
    func create(from pathContext: PathContext) throws -> Path {
        Path(title: pathContext.title)
    }
}
