//
//  File.swift
//
//
//  Created by Johan on 22/06/2020.
//

import Fluent

// 1
struct CreateAdminToken: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    // 2
    database.schema(AdminToken.schema)
       // 3
        .id()
      .field("admin_id", .uuid, .references("admins", "id"))
      .field("value", .string, .required)
      .unique(on: "value")
      .field("source", .int, .required)
      .field("created_at", .datetime, .required)
      .field("expires_at", .datetime)
      // 4
      .create()
  }

  // 5
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(AdminToken.schema).delete()
  }
}
