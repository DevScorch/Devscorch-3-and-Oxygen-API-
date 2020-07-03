//
//  File.swift
//  
//
//  Created by Johan on 02/07/2020.
//

import Foundation
import Vapor
import Fluent

enum AdminSessionSource: Int, Content {
    case signup
    case login
}

final class AdminToken: Model {
    static let schema = "admin_tokens"
    
    @ID(key: "id")
    var id: UUID?
    
    @Parent(key: "admin_id")
    var admin: Admin
    
    @Field(key: "value")
    var value: String
    
    @Field(key: "source")
    var source: AdminSessionSource
    
    @Field(key: "expires_at")
    var expiresAt: Date?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() {}
    
    init(id: UUID? = nil, adminId: Admin.IDValue, token: String,
      source: AdminSessionSource, expiresAt: Date?) {
      self.id = id
      self.$admin.id = adminId
      self.value = token
      self.source = source
      self.expiresAt = expiresAt
    }
}

extension AdminToken: ModelTokenAuthenticatable {
  static let valueKey = \AdminToken.$value
  static let userKey = \AdminToken.$admin
  
  var isValid: Bool {
    guard let expiryDate = expiresAt else {
      return true
    }
    
    return expiryDate > Date()
  }
}
