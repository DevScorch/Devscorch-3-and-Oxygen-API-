//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import FluentPostgresDriver
import Vapor

final class Path: Model, Content, Encodable {
    static let schema = "paths"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Children(for: \.$path)
    var courses: [Course]
    
    init() {}
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
    
}

extension Path {
    struct ViewContext: Encodable {
        var id: String
        var title: String
        var courses: [Course]
        
        init(model: Path) {
            self.id = model.id!.uuidString
            self.title = model.title
            self.courses = model.courses
        }
    }
    var viewContext: ViewContext { .init(model: self)}
}
