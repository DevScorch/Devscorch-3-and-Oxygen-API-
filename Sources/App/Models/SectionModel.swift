//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import FluentPostgresDriver
import Vapor

final class Section: Model, Content {
    static let schema = "sections"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "image")
    var image: String
    
    @Field(key: "lessons")
    var lessons: Int
    
    init() {}
    
    init(id: UUID, title: String, description: String, image: String, lessons: Int) {
        self.id = id
        self.description = description
        self.image = image
        self.lessons = lessons
    }
    
}
