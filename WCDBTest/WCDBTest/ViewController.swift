//
//  ViewController.swift
//  WCDBTest
//
//  Created by ksnowlv on 2024/8/8.
//

import UIKit
import WCDB

struct Person: TableCodable {
    static let tableName = "Person"
    
    
    var userId: String
    var name: String
    var age: Int
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Person
        case userId
        case name
        case age
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindIndex(userId, namedWith: "_userIdIndex", isUnique: true)
            BindIndex(name, namedWith: "_nameIndex", isUnique: true)
        }
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraint] {
            return [
                .userId: ColumnConstraint().primaryKey()
            ]
        }
        
    }
}




class ViewController: UIViewController {
    
    let database = Database(at: NSHomeDirectory() + "/Documents/myDatabase.db")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let filePath = NSHomeDirectory() + "/Documents/myDatabase.db"
        print("filePath:\(filePath)")
        self.testWCDB()
        
    }
    
    func testWCDB() {
        // Swift
        // 创建表
        do {
            try database.create(table: Person.tableName, of: Person.self)
            
        } catch {
            print(error.localizedDescription)
        }
        
      
        // 插入数据
        var persons = [Person(userId:  UUID().uuidString, name: "kk", age: 10),
                       Person(userId:  UUID().uuidString,name: "ksnowlv", age: 30),
                       Person(userId:  UUID().uuidString,name: "ksnow", age: 3)]
        
        let loopNum = 100000
        
        for i in 0..<loopNum {
            persons.append(Person(userId: UUID().uuidString, name: "name\(i)", age:i))
        }
     
        var startTime = CFAbsoluteTimeGetCurrent()
      
        do {
            
            for person in persons {
                try database.insertOrIgnore(person, intoTable: Person.tableName)
            }
           
        } catch {
            print(error.localizedDescription)
        }
        
       

        let deltaTime = (CFAbsoluteTimeGetCurrent() - startTime)*1000
        
        print("---插入数据耗时：\(deltaTime)")
     
        print("---插入数据后")
    
        showCurPersons()
        
        // 更新数据
        do {
            try database.update(table: Person.tableName, on: Person.CodingKeys.all, with: Person(userId: UUID().uuidString, name: "ksnowlv", age: 31), where: Person.CodingKeys.name == "ksnowlv")
        } catch {
            print(error.localizedDescription)
        }
        
        print("---更新数据后")
        
        showCurPersons();
      
        //
        do {
            try database.delete(fromTable: Person.tableName, where: Person.CodingKeys.name == "ksnow")
        } catch {
            print(error.localizedDescription)
        }
        print("---删除数据后")
        showCurPersons()
    }
    
    
    func showCurPersons()  {
        // 查询数据
        let startTime = CFAbsoluteTimeGetCurrent()
        do {
           
            let persons: [Person] = try database.getObjects(
                on: Person.Properties.all,
                fromTable: Person.tableName
//                limit: 200
            )
            
//            for person in persons {
//                print("userId:\(person.userId), Name: \(person.name), Age: \(person.age)")
//            }
        } catch {
            print(error.localizedDescription)
        }
        let deltaTime = (CFAbsoluteTimeGetCurrent() - startTime)*1000
        
        print("---查询数据耗时：\(deltaTime)")
        
    }
}

