//
//  File.swift
//  
//
//  Created by Johan on 13/09/2020.
//

import Vapor
import Foundation

struct SelectionForm: Encodable {
    var value: String = ""
    var error: String? = nil
    var options: [FormFieldOption] = []
}

struct FormFieldOption: Encodable {
    public let key: String
    public let label: String
    
    public init(key: String, label: String) {
        self.key = key
        self.label = label
    }
}

protocol FormFieldOptionRepresentable {
    var formFieldOption: FormFieldOption { get }
}
