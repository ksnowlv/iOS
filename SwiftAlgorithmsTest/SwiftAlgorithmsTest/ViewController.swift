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
}

