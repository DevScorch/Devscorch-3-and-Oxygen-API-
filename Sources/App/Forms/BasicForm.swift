//
//  File.swift
//  
//
//  Created by Johan on 10/09/2020.
//

import Foundation

struct BasicFormField: Encodable {
    var value: String? = ""
    var error: String?
    var intValue: Int?
}
