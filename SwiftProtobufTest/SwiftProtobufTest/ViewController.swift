//
//  ViewController.swift
//  SwiftProtobufTest
//
//  Created by ksnowlv on 2024/8/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testPB()
    }
    
    func testPB()  {
        
        var personInfo = PersonInfoPB()
        personInfo.name = "ksnow"
        personInfo.age = 30
        personInfo.id = 10
        personInfo.hobbies = ["reading", "swimming", "running"]
        
        //PersonInfoPB pb序列化到serializedData
        let serializedData = try? personInfo.serializedData()
        
        print("PersonInfoPB data:\(String(describing: serializedData))")
        
        // 反序列化 serializedData 到 PersonInfoPB 实例
        
        guard serializedData != nil else  {
            return
        }
        
        do {
            let person = try PersonInfoPB(serializedBytes: serializedData!)
            
            // 现在你可以使用 person 实例
            print("Name: \(person.name)")
            print("Age: \(person.age)")
            print("id: \(person.id)")
            print("hobbies: \(person.hobbies)")
        } catch {
            print("Failed to deserialize PersonInfoPB: \(error)")
        }
        
        // Deserialize a received Data object from `binaryData`
        if let personInfo = try? PersonInfoPB(serializedData: serializedData!) {
            //personInfo 实例
            print("Name: \(personInfo.name)")
            print("Age: \(personInfo.age)")
            print("id: \(personInfo.id)")
            print("hobbies: \(personInfo.hobbies)")
        }
        
        // PB对象序列化为 JSON 格式，JSON格式对象反序列化PersonInfoPB 实例
        // 序列化为 JSON 格式
        let jsonData: Data = try! personInfo.jsonUTF8Data()
        let jsonString = try! personInfo.jsonString()
        
        print("jsonData: \(jsonData)")
        print("jsonString: \(jsonString)")
        
        do {
            // JSON格式对象反序列化为 PersonInfoPB 实例
            let personInfo = try PersonInfoPB(jsonUTF8Bytes: jsonData)
            
            print("Name: \(personInfo.name)")
            print("Age: \(personInfo.age)")
            print("Hobbies: \(personInfo.hobbies)")
        } catch {
            print("Failed to deserialize JSON to PersonInfoPB: \(error)")
        }
        
    }
    
}

