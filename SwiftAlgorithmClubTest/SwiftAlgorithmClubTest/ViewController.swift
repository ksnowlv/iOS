//
//  ViewController.swift
//  SwiftAlgorithmClubTest
//
//  Created by ksnowlv on 2024/8/17.
//

import UIKit

class DoublyLinkedList<Key,Value> {
   class Node {
       var key:Key?
       var value:Value?
       var next:Node?
       var prev:Node?
       
       init(key:Key?,value:Value?) {
           self.key = key
           self.value = value
       }
   }
   
   private var head = Node(key:nil,value:nil)
   private var tail = Node(key:nil,value:nil)
   
   init() {
       head.next = tail
       tail.prev = head
   }
   
   func addToHead(_ node:Node) {
       node.next = head.next
       node.prev = head
       head.next?.prev = node
       head.next = node
   }
   
   func removeNode(_ node:Node) {
       node.prev?.next = node.next
       node.next?.prev = node.prev
   }
   
   func moveToHead(_ node:Node) {
       removeNode(node)
       addToHead(node)
   }
   
   func removeTail() -> Node?{
       if let tailNode = tail.prev,tailNode !== head {
           removeNode(tailNode)
           return tailNode
       }
       return nil
   }
}

class LRUCacheNew<Key:Hashable,Value> {
   private let capacity:Int
   private var cache:[Key:DoublyLinkedList<Key,Value>.Node] = [:]
   private let list:DoublyLinkedList<Key,Value>
   
   init(capacity:Int) {
       self.capacity = capacity
       self.list = DoublyLinkedList<Key,Value>()
   }
   
   func get(_ key:Key) -> Value?{
       if let node = cache[key] {
           list.moveToHead(node)
           return node.value
       }
       return nil
   }
   
   func put(_ key:Key,_ value:Value) {
       if let node = cache[key] {
           node.value = value
           list.moveToHead(node)
       } else {
           let newNode = DoublyLinkedList<Key,Value>.Node(key:key,value:value)
           cache[key] = newNode
           list.addToHead(newNode)
           
           if cache.count > capacity {
               if let tailNode = list.removeTail() {
                   cache[tailNode.key!] = nil
               }
           }
       }
   }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testLRU()
        self.testLRUNew()
    }
    
    func testLRU() {
        let maxNum = 2
        let lruCache = LRUCache<String>(maxNum)
        
        let loopNum = 10
        
        for i in 0..<loopNum {
           
            lruCache.set("key\(i)", val: "value\(i)")
        }
        
        
        for i in 0..<loopNum {
            if let value = lruCache.get("key\(i)") {
              print("Value for key\(i):", value)
            }
        }
        
        print("end")
        
    }
    
    func testLRUNew() {
        let maxNum = 2
        let lurCache = LRUCacheNew<String,String>(capacity:maxNum)
        
        let loopNum = 10
        
        for i in 0..<loopNum {
           
            lurCache.put("key\(i)", "value\(i)")
        }
        
        
        for i in 0..<loopNum {
            if let value = lurCache.get("key\(i)") {
              print("Value for key\(i):", value)
            }
        }
        
        print("end")
        
    }


}

