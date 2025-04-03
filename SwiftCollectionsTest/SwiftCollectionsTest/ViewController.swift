//
//  ViewController.swift
//  SwiftCollectionsTest
//
//  Created by ksnowlv on 2024/9/8.
//

import UIKit
import Collections
import os.log

// 设置日志标签
let tag = "com.ios.app"


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testDeque()
        self.testHeap()
        self.testOrderedDictionary()
        self.testOrderedSet()
        self.testTreeSet()
        self.testTreeDictionary()
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
        
        let loopNum = 20
        
        for i in 0..<loopNum {
            heap.insert(i)
        }
        
        
        
        print("heap min:\(heap.min), max:\(heap.max)")
        
        while let min = heap.popMin() {
            print("Next smallest element:", min)
        }
        
        for i in 0..<loopNum {
            heap.insert(i)
        }
        
        while let max = heap.popMax() {
            print("Next largest element:", max)
        }
        
        for i in 0..<loopNum {
            heap.insert(i)
        }
        
        for val in heap.unordered {
            print("heap:\(val)")
        }
        
        heap.replaceMax(with: 100)
        heap.replaceMin(with: 3)
        
        print("heap min:\(heap.min), max:\(heap.max)")
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
    
    func testTreeSet()  {
        let loopNum = 1_000
        var set = TreeSet(0 ..< loopNum)
        let copy = set
        set.insert(20_000) // Expected to be an O(log(n)) operation
        let diff = set.subtracting(copy) // Also O(log(n))!
        // `diff` now holds the single item 20_000.
        
        //Finding Elements
        
        var num = 99
        var res = set.contains(num)
        
        print("\(num) contains in set:\(res)")
        
        
        num = 99
        
        if let index = set.firstIndex(of: num) {
            
            print("\(num) firstIndex:\(index)")
        }
        
        if let index = set.lastIndex(of: num) {
            
            print("\(num) lastIndex:\(index)")
        }
        
        //Adding and Updating Elements
        
        let insertRes = set.insert(num)
        
        print("\(num) inserted:\(insertRes.inserted) memberAfterInsert:\(insertRes.memberAfterInsert)")
        
        num = 2_000
        let insertRes1 = set.insert(num)
        
        print("\(num) inserted:\(insertRes1.inserted) memberAfterInsert:\(insertRes1.memberAfterInsert)")
        
        num = 10
        if let updateRes =  set.update(with: num) {
            print("\(num) update:\(updateRes) memberAfterInsert:\(insertRes.memberAfterInsert)")
        }
        
        num = 11
        
        //        if let index =  set.firstIndex(of: 100) {
        //            let res = set.update(200, at: index)
        //            print("100 update:\(res)")
        //        }
        
        //Removing Elementsin page link
        
        let removeRes = set.remove(200) ?? 0
        
        print("remove:\(removeRes)")
        
        set.removeAll {
            return $0 > 100
        }
        
        let newSet = set.filter {
            $0 % 2 == 0
        }
        
        print(newSet)
        
        set.removeAll {
            return $0 > 30
        }
        
        set.forEach { e in
            print("set element:\(e)")
        }
        
    }
    
    func testTreeDictionary() {
        
        var treeDictionary = TreeDictionary(uniqueKeysWithValues: (0 ..< 100).map { ($0, 2 * $0) })
        
        print("---treeDictionary")
        treeDictionary.forEach { (key: Int, value: Int) in
            print("key:\(key), value:\(value)")
        }
        let copy = treeDictionary
        treeDictionary[2000] = 42 // Expected to be an O(log(n)) operation
        let diff = treeDictionary.keys.subtracting(copy.keys) // Also O(log(n))!
        // `diff` now holds the single item 20_000.
        print("diff:\(diff)")
        print("---treeDictionary1")
        copy.forEach { (key: Int, value: Int) in
            print("key:\(key), value:\(value)")
        }
        
        //查询是否为空，数量，所有的key，value值
        print("treeDictionary isEmpty \(treeDictionary.isEmpty)")
        print("treeDictionary count \(treeDictionary.count)")
        print("treeDictionary keys \(treeDictionary.keys)")
        print("treeDictionary values \(treeDictionary.values)")
        //添加key/value
        treeDictionary[20000] = 1000
        print("treeDictionary treeDictionary[20000]: \(treeDictionary[20000] ?? 0)")
        
        treeDictionary.updateValue(10001, forKey: 20000)
        print("treeDictionary treeDictionary[20000]: \(treeDictionary[20000] ?? 0)")
        
        var treeDictionary2 = TreeDictionary<Int, Int>()
        treeDictionary2[3000] = 3000
        treeDictionary2[3001] = 3001
        treeDictionary2[3002] = 3002
        treeDictionary[20000] = 0
        
        
        // 使用 merge 方法合并序列到字典中
//        treeDictionary.merge(treeDictionary2, uniquingKeysWith: { (existingValue, newValue) -> Int in
//            // 这里我们可以选择保留 existingValue 或 newValue，或者将它们组合起来
//            // 例如，我们可以选择保留新的值，或者合并两个值
//            print("---existingValue:\(existingValue),newValue:\(newValue)")
//            return existingValue // 假设我们想要将两个值合并起来
//            
//        })
        
        //合并字典
        treeDictionary.merge([10000:1,100000:2,20000:2222]) { v1, v2 in
            
            v2
        }
        
        // 打印合并后的字典
        print("after merge:\(treeDictionary)")
        
        treeDictionary.removeAll {
            
            return $0.key > 10
        }
        
        print("after remove:\(treeDictionary)")
        //移除
        treeDictionary.removeValue(forKey: 8)
        
        print("after remove key 8:\(treeDictionary)")
        
        //过滤
        let filterTreeDictionary = treeDictionary.filter { (key: Int, value: Int) in
            return key < 5
        }
        print("key < 5 all element:\(filterTreeDictionary)")
    }
    
}

