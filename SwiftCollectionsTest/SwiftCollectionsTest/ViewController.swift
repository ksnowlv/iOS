//
//  ViewController.swift
//  SwiftCollectionsTest
//
//  Created by ksnowlv on 2024/9/8.
//

import UIKit
import Collections

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testDeque()
        self.testHeap()
        self.testOrderedDictionary()
        self.testOrderedSet()
    }
    
    func testDeque() {
        var colors: Deque = ["red", "yellow", "blue","black"]
        
        colors.prepend("green")
        colors.append("orange")
        // `colors` is now ["green", "red", "yellow", "blue","black", "orange"]
        
        print("colors:\(colors)")
        
        // pop green
        if  let first =   colors.popFirst() {
            print("pop green:\(first) colors:\(colors)")
        }
        
        if let last = colors.last {
            colors.popLast() // "orange"
            print("pop orange:\(last) colors:\(colors)")
        }
        
        colors.prepend(contentsOf: ["purple", "teal"])
        print("colors:\(colors)")
        
        colors.insert("white", at: 1)
        print("after insert white colors:\(colors)")
        
        let removeObject = colors.remove(at: 1)
        print("after remove white color, colors:\(colors)")
    }
    
    func testHeap() {
        var heap = Heap<Int>()
        
        for i in 0..<50 {
            heap.insert(i)
        }
        
        
        print("heap min:\(heap.min), max:\(heap.max)")
        
        while let min = heap.popMin() {
            print("Next smallest element:", min)
        }
        
        while let max = heap.popMax() {
            print("Next largest element:", max)
        }
        
        for val in heap.unordered {
            print("heap:\(val)")
        }
    }
    
    func testOrderedDictionary() {
        
        //按顺序输出OrderedDictionary中的内容，无论多少次
        var responses: OrderedDictionary = [
            200: "OK",
            404: "File not found",
            403: "Access forbidden",
            500: "Internal server error",
        ]
        
        print("responses:\(responses)")
        
        // 添加新元素，按添加的顺序存储
        responses[499] = "client close session"
        responses[504] = "time out"
        
        print("add 499,50, responses:\(responses)")
        
        // 按顺序,输出所有的key，value
        print("responses allKey:\(responses.keys),allValue:\(responses.values)")
        
        
        // Complexity: O(*n* log *n*), where *n* is the length of the collection 排序后,输出所有的key，value
        responses.sort()
        
        print("after sort responses:\(responses)")
        
        // 逆序后,输出所有的key，value
        let sortedResponses = responses.sorted { $0.key>$1.key }
        
        for (key, value) in sortedResponses {
            print("\(key): \(value)")
        }
        
        
        //查找 key
        var httpStatusCode = 500
        if let index = responses.index(forKey: httpStatusCode) {
            
            let (key, value) = responses.elements[index]
            print("http status code for \(value): '\(key) ")
        }
        
        httpStatusCode = 401
        if let index = responses.index(forKey: httpStatusCode) {
            
            
        } else {
          
            print("http status code\(httpStatusCode) not found! ")
        }
        
        //更新key
        httpStatusCode = 500
        
        if let oldValue = responses.updateValue("Internal server error", forKey: httpStatusCode) {
            print("The old value of \(oldValue) was replaced with a new one.")
        } else {
            print("No value was found in the dictionary for that key.")
        }
        
        //移除key&value
        httpStatusCode = 499
        
        if let removeValue = responses.removeValue(forKey: httpStatusCode) {
            print("The value \(removeValue) was removed.")
        } else {
            print("No value found for that key.")
        }
        
        httpStatusCode = 999
        
        if let removeValue = responses.removeValue(forKey: httpStatusCode) {
            print("The value \(removeValue) was removed.")
        } else {
            print("No value found for that key.")
        }
        
        //大于400过滤掉filter
       let newResponses =  responses.filter { (key: Int, value: String) in
           return (key >= 400)
        }
        
        print("after filter,newResponses:\(newResponses)")
        //字典的value值映射
        let resMapValues =  responses.mapValues { v in
            "value:\(v)"
        }
        
        print("resMapValues:\(resMapValues)")
    }
    
    func testOrderedSet() {
        //梨的英文是 “pear”, 西瓜的英文是 “watermelon”, 葡萄的英文是 “grape”, 樱桃的英文是 “cherry”。
        var fruits: OrderedSet = ["apple", "banana", "pear"]
        
        var otherFruits:OrderedSet = ["grape","cherry"]
       
        // union
        fruits = fruits.union(otherFruits)
        
        print("fruits:\(fruits)")
        
        
        //append
        fruits.append("watermelon")
        
        print("fruits:\(fruits)")
        
        //insert
        fruits.insert("Orange", at: 0)
        fruits.insert("Strawberry", at: 0)//草莓
        fruits.insert("Blueberry", at: 0)//蓝莓
        print("fruits:\(fruits)")
        
        //update
        let index = fruits.updateOrInsert("Peach", at: 0)
        
        print("fruits index :\(index), fruits:\(fruits)")
        
        //find
        if let index = fruits.firstIndex(of: "Peach")   {
            print("Peach index:\(index)")
        }
        
        //remove
        
        if let element = fruits.remove("Peach") {
            print("the removed element:\(element)")
        }
        
        fruits.append("Pineapple")
        fruits.append("Persimmon")
        fruits.append("Grapefruit")
        fruits.append("Kiwi")
        fruits.append("Lychee")
        
        //sort
        fruits.sort()
        
        print("sort fruits:\(fruits)")
        
        fruits.sort {
            return $0 > $1
        }
        print("reverse sort fruits:\(fruits)")
        
        otherFruits.append("Lychee")
        otherFruits.append("Kiwi")
        otherFruits.append("Durian")
        otherFruits.append("Dragon fruit")
        
        //交集
        let intersection = fruits.intersection(otherFruits)
        print("intersection fruits:\(intersection)")
        
        //补集
        let subtracting = fruits.subtracting(otherFruits)
        print("subtracting fruits:\(subtracting)")
        
    }
    
 
}

