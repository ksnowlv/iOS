//
//  ViewController.swift
//  GRDBTest
//
//  Created by ksnowlv on 2024/8/10.
//

import UIKit

class ViewController: UIViewController {
    
    let store = GRDBStore()
    let loopNum = 100000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testGRDB()
    }
    
    func testGRDB() {
        
        
        // 插入数据
        var persons = [GRDBData(UUID().uuidString, "kk", 10),
                       GRDBData(UUID().uuidString,"ksnowlv", 30),
                       GRDBData(UUID().uuidString,"ksnow", 3)]
        
        
        
        for i in 0..<loopNum {
            persons.append(GRDBData(UUID().uuidString, "name\(i)", i))
        }
        
        var startTime = CFAbsoluteTimeGetCurrent()
        
//        store.insertUsers(persons)
        store.insertUsersWithTransaction(persons)
        
        let deltaTime = (CFAbsoluteTimeGetCurrent() - startTime)*1000
        
        print("---插入数据耗时：\(deltaTime)")
        
        print("---插入数据后")
        let result:([GRDBData], Bool ) = self.showCurPersons()
        
        if !result.0.isEmpty {
            self.store.deleteUser(result.0[0].userId ?? "")
            
            print("---删除数据后")
            showCurPersons()
        }
    }
    
    func showCurPersons() -> ([GRDBData], Bool ) {
        // 查询数据
        let startTime = CFAbsoluteTimeGetCurrent()
        let result = self.store.fetchItems(self.loopNum + 10)
        let deltaTime = (CFAbsoluteTimeGetCurrent() - startTime)*1000
        print("---查询数据耗时：\(deltaTime)")
        return  result
    }
    
    
}

