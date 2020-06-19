//
//  File.swift
//  
//
//  Created by Johan on 18/06/2020.
//

import Fluent
import FluentPostgresDriver
import Vapor

final class Tutorial: Model, Content {
    static let schema = "tutorials"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "downloadURL")
    var downloadURL: String
    
    init() {}
    
    init(id: UUID, title: String, description: String, downloadURL: String) {
        self.id = id
        self.title = title
        self.description = description
        self.downloadURL = downloadURL
    }
}
