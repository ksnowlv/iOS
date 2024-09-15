//
//  LRUCache.swift
//
//
//  Created by Kai Chen on 16/07/2017.
//
//

import Foundation

public class LRUCache<KeyType: Hashable> {
    private let maxSize: Int
    private var cache: [KeyType: Any] = [:]
    private var priority:[KeyType] = [KeyType]()
    private var key2node: [KeyType: LinkedList<KeyType>.LinkedListNode<KeyType>] = [:]
    
    public init(_ maxSize: Int) {
        self.maxSize = maxSize
    }
    
    public func get(_ key: KeyType) -> Any? {
        guard let val = cache[key] else {
            return nil
        }
        
        remove(key)
        insert(key, val: val)
        
        return val
    }
    
    public func set(_ key: KeyType, val: Any) {
        if cache[key] != nil {
            remove(key)
        } else if priority.count >= maxSize, let keyToRemove = priority.last {
            remove(keyToRemove)
        }

        insert(key, val: val)
    
    }
    
    private func remove(_ key: KeyType) {
        
        guard let node = key2node[key] else {
            return
        }
        
        cache.removeValue(forKey: key)
        
        if let index = priority.firstIndex(of:key) {
           priority.remove(at:index)
        } else {
           print("无法找到要删除的元素")
        }
        key2node.removeValue(forKey: key)
    }
    
    private func insert(_ key: KeyType, val: Any) {
        cache[key] = val
        priority.insert(key, at: 0)
        let newNode =  LinkedList<KeyType>.LinkedListNode<KeyType>(value: val as! KeyType)
        key2node[key] = newNode

    }
}
