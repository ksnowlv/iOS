//
//  Person.swift
//  SwiftUIDataToUIKItTest
//
//  Created by ksnowlv on 2024/10/7.
//

import UIKit

class Person: NSObject, Codable,ObservableObject {
    @Published var name: String
    @Published var age: Int
    @Published var address: String

    // 此处为 Decodable 协议要求的初始化方法
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy:CodingKeys.self)
        self.name = try container.decode(String.self,forKey:.name)
        self.age = try container.decode(Int.self,forKey:.age)
        self.address = try container.decode(String.self,forKey:.address)
    }
    // 此处为 Codable 协议要求的编码方法
    func encode(to encoder:Encoder) throws {
        var container = encoder.container(keyedBy:CodingKeys.self)
        try container.encode(name,forKey:.name)
        try container.encode(age,forKey:.age)
        try container.encode(address,forKey:.address)
    }


    init(name:String,age:Int,address:String) {
        self.name = name
        self.age = age
        self.address = address
    }

    private enum CodingKeys:String,CodingKey {
        case name
        case age
        case address
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age && lhs.address == rhs.address
    }
}
