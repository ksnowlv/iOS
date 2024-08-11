//
//  GRDBData.swift
//  GRDBTest
//
//  Created by ksnowlv on 2024/8/10.
//

import Foundation
import GRDB

struct GRDBData : Codable, FetchableRecord, TableRecord, MutablePersistableRecord{
    
    static let tableUserId = "userId"
    static let tableUserName = "name"
    static let tableUserAge = "age"
    
    var userId: String?
    var name: String
    var age: Int
    
    static let databaseTableName = "UserInfo"
    
    
    init(_ userId: String? = nil, _ name: String, _ age: Int) {
        self.userId = userId
        self.name = name
        self.age = age
    }
    
    // 从数据库行数据初始化
    init(row: Row) {
        userId = row[GRDBData.tableUserId]
        name = row[GRDBData.tableUserName]
        age = row[GRDBData.tableUserAge]
    }
    
    // 将模型数据保存到数据库行
      mutating func encode(to container: inout PersistenceContainer) {
          container[GRDBData.tableUserId] = userId
          container[GRDBData.tableUserName] = name
          container[GRDBData.tableUserAge] = age
      }
    
}

extension GRDBData {
    enum Columns {
        static let userId = Column(CodingKeys.userId)
        static let name = Column(CodingKeys.name)
        static let age = Column(CodingKeys.age)
    }
}

