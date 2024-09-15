//
//  ViewController.swift
//  SwiftAlgorithmsTest
//
//  Created by ksnowlv on 2024/8/15.
//

import UIKit
import Algorithms

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testChunked()
        self.testGrouped()
        self.testCombinations()
    }
    
    func testChunked()  {
        let numbers = [10, 20, 30, 10, 40, 40, 10, 20,3,10,100, 8,10]
        let numberChunks = numbers.chunked(by: { $0 <= $1 })
        
        var count = 0
        for item in numberChunks {
            count += 1
            print("numberChunk \(count): \(item)")
        }
        
        let names = ["Cassie", "Chloe", "Jasmine", "Jordan", "Taylor", "Ksnow","lucy","Kite","han", "l","J","t"]
        let nameChunks = names.chunked(on: \.first)
        
        count = 0
        for item in nameChunks {
            count += 1
            print("nameChunk \(count): \(item)")
        }
        
        
    }
    
    func testOrderSet() {
        let set = NSOrderedSet()
  
    }
    
    func testCombinations() {
        let numbers = [10, 20, 30, 40]
        for combo in numbers.combinations(ofCount: 2) {
            print(combo)
        }
        
        let numbers2 = [20, 10, 10]
        for combo in numbers2.combinations(ofCount: 2) {
            print(combo)
        }
        
        let numbers3 = [10, 20, 30, 40]
        for combo in numbers3.combinations(ofCount: 2...3) {
            print(combo)
        }
    }
    
    func testGrouped() {
        let fruits = ["Apricot", "Banana","grape","pineapple","watermelon", "Apple", "Cherry", "Avocado", "Coconut"]
        let fruitsByLetter = fruits.grouped(by: { $0.first! })
        // Results in:
        // [
        //     "B": ["Banana"],
        //     "A": ["Apricot", "Apple", "Avocado"],
        //     "C": ["Cherry", "Coconut"],
        // ]
    }
}

