//
//  ViewController.swift
//  SendableTest
//
//  Created by ksnowlv on 2024/10/26.
//

import UIKit



struct Counter: Sendable {
    var count = 0
    
    mutating func incrementCounter(_ count: Int) {
        self.count += count
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var counter = Counter()

        DispatchQueue.global().async {
            // 安全地在线程间传递 Counter 实例, 创建独立的实例
            var globalCounter = Counter()
            globalCounter.incrementCounter(1)
            print("newCounter.count in global queue:\(globalCounter.count)")
        }
        
        DispatchQueue.main.async {
            // 安全地在线程间传递 Counter 实例,创建独立的实例
            var mainCounter = Counter()
            mainCounter.incrementCounter(2)
            print("newCounter.count in main queue:\(mainCounter.count)")
        }
        
        
    }
}

