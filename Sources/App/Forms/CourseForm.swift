//
//  File.swift
//  
//
//  Created by Johan on 10/09/2020.
//

import Foundation
import Vapor

final class CourseForm: Encodable {
    
        var id: String? = nil
        var title = BasicFormField()
        var description = BasicFormField()
        var lessons = BasicFormField()
        var assets = BasicFormField()
        var image = FileFormField()
        var pathID = SelectionForm()
    
        
        init() {}
        
        init(req: Request) throws {
            let context = try req.content.decode(CoursePostContext.self)
            if (context.id?.isEmpty)! {
                self.id = context.id
            }
            self.image.delete = context.imageDelete ?? false
            if let image = context.image, let data = image.data.getData(at: 0, length: image.data.readableBytes), !data.isEmpty {
                self.image.data = data
            }
            
            self.title.value = context.title
            self.description.value = context.description
            self.lessons.intValue = context.lessons
            self.assets.value = context.assets
            self.pathID.value = context.pathID
        }
    
    func writeCourse(to model: Course) {
        model.title = self.title.value!
        model.description = self.description.value!
        model.lessons = self.lessons.intValue!
        model.assets = self.assets.value!
        model.image = self.image.value
        model.path.id = UUID(uuidString: self.pathID.value)
        
        if !self.image.value.isEmpty {
            model.image = self.image.value
        }
        
        if self.image.delete {
            model.image = ""
        }
        
    }
}

extension CourseForm {
    
    func validate(_ req: Request) -> EventLoopFuture<Bool>  {
        var valid = true
        
        if self.title.value!.isEmpty {
            self.title.error = "You forgot to add your title :("
            valid = false
        }
        if self.description.value!.isEmpty {
            self.description.error = "You forgot to add your description :("
            valid = false
        }
        if self.lessons.value!.isEmpty {
            self.lessons.error = "You forgot to add the amount of lessons :("
            valid = false
        }
        if self.assets.value!.isEmpty {
            self.assets.error = "You forgot to add your assets :("
            valid = false
        }
        if self.image.value.isEmpty {
            self.image.error = "You forgot to add your image :("
            valid = false
        }
        
        let uuid = UUID(uuidString: self.pathID.value)
        return Path.find(uuid, on: req.db).map { model in
            if model == nil {
                self.pathID.error = " You have to select a Category :("
                valid = false
            }
            return valid
            
        }
        
        
    }
}

