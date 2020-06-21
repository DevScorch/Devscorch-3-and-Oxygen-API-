//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import FluentPostgresDriver
import Fluent
import Vapor

final class Lesson: Model, Content {
    static let schema = "lessons"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "duration")
    var duration: String
    
    @Field(key: "number")
    var number: Int
    
    init() {}
    
    init(id: UUID, title: String, duration: String, number: Int) {
        self.id = id
        self.duration = duration
        self.number = number
    }
    
}
