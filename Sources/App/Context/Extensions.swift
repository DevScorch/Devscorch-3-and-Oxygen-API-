//
//  File.swift
//  
//
//  Created by Johan on 23/06/2020.
//

import Vapor
import Fluent


extension UserSignUp: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: !.empty)
        validations.add("password", as: String.self, is: .count(6...))
       // validations.add("email", as: String.self, is: !.empty)
    }
}

extension AdminSignUp: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: !.empty)
        validations.add("password", as: String.self, is: .count(6...))
       // validations.add("email", as: String.self, is: !.empty)
    }
}



