//
//  File.swift
//  
//
//  Created by Johan on 29/06/2020.
//

import Vapor
import Fluent
import FluentPostgresDriver

struct UserCredentialAuthenticator: CredentialsAuthenticator {
    
    
    typealias Credentials = LoginPostData
    
    func authenticate(credentials: Credentials, for req: Request) -> EventLoopFuture<Void> {
        Student.query(on: req.db).filter(\.$username == credentials.username).first().map {
            do {
                if let user = $0,
                try Bcrypt.verify(credentials.password, created: user.password) {
                    req.auth.login(user)
                }
            } catch {
                
            }
        }
    }
}

struct UserSessionAuthenticator: SessionAuthenticator {
    
    typealias User = Student
    func authenticate(sessionID: User.SessionID, for req: Request) -> EventLoopFuture<Void> {
        User.find(sessionID, on: req.db).map { user in
            if let user = user {
                req.auth.login(user)
            }
        }
    }
}
