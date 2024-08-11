//
//  GRDBStore.swift
//  GRDBTest
//
//  Created by ksnowlv on 2024/8/10.
//

import Foundation

import GRDB
import CommonCrypto

class GRDBStore {
    
    private static let GRDBFileName = "GRDBStoreDB.sqlite"
    
    private lazy var filePath: String = {
        let dbFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(GRDBStore.GRDBFileName).path
        print("db filePath:\(String(describing: dbFilePath))")
        return dbFilePath ?? ""
    }()
    
    private lazy var dbQueue:DatabaseQueue? = {
        do {
            var configuration = Configuration()
            
            
#if DEBUG
            configuration.label = "GRDB" // 设置数据库标签，用于日志和调试
            // Enable verbose debugging in DEBUG builds only
//            configuration.publicStatementArguments = true
//            configuration.prepareDatabase { db in
//                db.trace(options: .profile) { event in
//                    
//                    print(event)
//                    if  case let .profile(statement, duration) = event, duration > 0.2 {
//                        print("Slow query: \(statement.sql)")
//                    }
//                    
//                }
//            }
#endif
            
            let queue = try DatabaseQueue(path: filePath, configuration: configuration)
            createTable(queue)
            return queue
        } catch {
            print("Failed to open database: \(error)")
        }
        
        return nil
    }()
    
    
    func createTable(_ queue:DatabaseQueue?) {
        do {
            try queue?.write { db in
                // 创建表
                try db.create(table: GRDBData.databaseTableName, ifNotExists: true) { table in
                    
//                    table.autoIncrementedPrimaryKey(GRDBData.tableUserId)
                    table.primaryKey(GRDBData.tableUserId, .text).notNull().unique()
                    table.column(GRDBData.tableUserName, .text).notNull()//.unique()
                    table.column(GRDBData.tableUserAge, .integer).notNull()
                }
                
                try db.create(index: "index_\(GRDBData.tableUserId)", on: GRDBData.databaseTableName, columns: [GRDBData.tableUserId],unique: true, ifNotExists: true)
                
            }
        } catch {
            print("Database setup failed: \(error)")
        }
    }
    
    func insertUser(_ name:String, _ age : Int) {
        do {
            let userId = UUID().uuidString
            try dbQueue?.write { db in
                var data = GRDBData(userId, name, age)
                try data.insert(db, onConflict: .ignore)
            }
        } catch {
            print("Failed to insert event data: \(error)")
        }
    }
    
    
    func insertUsers(_ users:[GRDBData]) {
        
        do {
            try dbQueue?.write { db in
                for var user in users {
                    try user.insert(db,onConflict:.ignore)
                }
            }
        }
        catch {
            print("Failed to insert events:\(error)")
        }
    }
    
    func insertUsersWithTransaction(_ users:[GRDBData]) {
        
        do {
            
            try dbQueue?.inTransaction(.exclusive,{ db in
                
                do {
                    for var user in users {
                        try user.insert(db, onConflict: .ignore)
                        //                        try eventData.insert(db)
                    }
                    // 如果所有插入操作都成功，返回 .commit 提交事务
                    return .commit
                } catch {
                    // 如果发生错误，返回.rollback并回滚事务
                    print("Error inserting users: \(error)")
                    return .rollback
                }
            })
            
        } catch {
            print("Failed to insert users:\(error)")
        }
    }
    
    
    func deleteUser(_ userId: String) {
        do {
            try dbQueue?.write { db in
                
                try GRDBData.filter(Column(GRDBData.tableUserId) == userId).deleteAll(db)
            }
        } catch {
            print("Database write failed: \(error)")
        }
    }
    
    func delteUsers(_ users: [String]) {
        do {
            try dbQueue?.write { db in
                // 批量删除部分记录
                for user in users {
                    try GRDBData.filter(GRDBData.Columns.userId == user).deleteAll(db)
                }
                
            }
        } catch {
            print("Database write failed: \(error)")
        }
    }
    
    func fetchItems(_ limitNumber: Int = 100) -> ([GRDBData], Bool ){
        var items: [GRDBData] = []
        do {
            let request = GRDBData.all().limit(limitNumber)
            try dbQueue?.read{ db in
                do {
                    items = try request.fetchAll(db)
                } catch {
                    print("Error fetching items: \(error)")
                }
            }
        } catch {
            print("Database read failed: \(error)")
        }
        
        return (items, items.count == limitNumber)
        
    }
    
}
