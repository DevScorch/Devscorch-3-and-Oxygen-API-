//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import FluentPostgresDriver
import Fluent
import Vapor

final class Course: Model, Content {
    static let schema = "courses"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "lessons")
    var lessons: Int
    
    @Field(key: "image")
    var image: String
    
    @Field(key: "assets")
    var assets: String
    
    @Parent(key: "path_id")
    var path: Path
    
    init() {}
    
    init(id: UUID, title: String, description: String, lessons: Int, image: String, assets: String, path: Path) {
        self.id = id
        self.title = title
        self.description = description
        self.lessons = lessons
        self.image = image
        self.assets = assets
        self.path = path
    }
    
    
}
