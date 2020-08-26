//
//  File.swift
//
//
//  Created by Johan on 09/08/2020.
//

import Foundation
import Vapor

struct BackendController: RouteCollection{
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("oxygen-admin", use: indexHandler)
    }
    
    
    // MAR: Backend Index Handler
    
    func indexHandler(_ req: Request) throws -> EventLoopFuture<View> {
        return req.view.render(adminIndex)
    }
}
