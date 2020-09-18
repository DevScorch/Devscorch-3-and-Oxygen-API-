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
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "lessons")
    var lessons: Int
    
    @Field(key: "image")
    var image: String
    
    @Field(key: "imageKey")
    var imageKey: String?
    
    @Field(key: "assets")
    var assets: String
    
    @Parent(key: "path_id")
    var path: Path
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil, title: String, description: String, lessons: Int, image: String, imageKey: String? = nil, assets: String, pathID: UUID) {
        self.id = id
        self.title = title
        self.description = description
        self.lessons = lessons
        self.image = image
        self.imageKey = imageKey
        self.assets = assets
        self.$path.id = pathID
    }
}

extension Course {
    struct ViewContext: Encodable {
        var id: String
        var title: String
        var description: String
        var lessons: Int
        var assets: String
        var createdAt: Date
        var updatedAt: Date
        
        init(model: Course) {
            self.id = model.id!.uuidString
            self.title = model.title
            self.description = model.description
            self.lessons = model.lessons
            self.assets = model.assets
            self.createdAt = model.createdAt!
            self.updatedAt = model.updatedAt!
        }
    }
    var viewContext: ViewContext {.init(model: self)}
}


