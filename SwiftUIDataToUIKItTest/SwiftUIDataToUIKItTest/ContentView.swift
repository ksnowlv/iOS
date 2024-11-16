//
//  ContentView.swift
//  SwiftUIDataToUIKItTest
//
//  Created by ksnowlv on 2024/10/7.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var person = Person(name: "张三", age: 25, address: "中国北京")
    @State private var year = 2024
    
    
    var body: some View {
        VStack {
            
            Text("SwiftUI 自动传递数据给UIKit")
            
            PersonView(person: person, year: $year)
            
            // 添加一些修改Person对象的按钮
            Text("person info name:\(person.name), age:\(person.age),address:\(person.address)")
            Spacer(minLength: 20.0)
            Button("年龄+1") {
                person.age += 1
                print("person age:\(person.age)")
            }
            
            Button("年龄-1") {
                person.age -= 1
                print("person age:\(person.age)")
            }
            
            Button("更改地址") {
                person.address = "中国上海"
                print("person address:\(person.address)")
            }
            
            
            Text("year:\(year)")
            
            Button("year+1") {
                year += 1
                print("year:\(year)")
            }
            
            Button("year-1") {
                year -= 1
                print("year:\(year)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
