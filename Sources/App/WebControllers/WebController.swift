//
//  File.swift
//  
//
//  Created by Johan on 19/06/2020.
//

import Vapor
import Leaf
import Fluent

struct WebsiteController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
            
        //MARK: Authentication routes
        routes.get(use: indexHandler)
 
        
    }
    
    func indexHandler(_ req: Request) throws -> EventLoopFuture<View> {
        let context = IndexContext(title: "Devscorch 3.0 | Home")
        return req.view.render("oxygen-web/index", context)
    }
}
