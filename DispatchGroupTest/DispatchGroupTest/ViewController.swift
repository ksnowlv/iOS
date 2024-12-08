//
//  ViewController.swift
//  DispatchGroupTest
//
//  Created by Mac on 2024/12/8.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testDispatchGroupConcurrent()
        testDispatchGroupSerial()
    }
    
    func testDispatchGroupConcurrent() {
        let maxNum = 3
        let dispatchGroup = DispatchGroup()

        // 定义一个函数来执行打印任务，避免重复代码
        func printNumbers(start: Int) {
            for i in start..<start + maxNum {
                print("\(start + i) execute")
            }
        }
        
        for i in 0..<maxNum {
            let queue = DispatchQueue(label: "DispatchQueue\(i)")
            print("\(queue.label) execute")
            queue.async(group: dispatchGroup) {
                printNumbers(start: i * maxNum)
            }
        }
        
        // 当所有任务完成后，在主队列上执行
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("main queue execute!")
        }

        // 如果你需要确保在继续之前所有任务都已完成，可以保留 wait
        // 如果确实需要同步等待，以下代码是可选的
        let result = dispatchGroup.wait(timeout: .now() + 5)
        if result == .success {
            print("所有任务在指定时间内完成")
        } else {
            print("等待超时，任务可能没有完成")
            // 这里可以添加超时的错误处理逻辑
        }
    }
    
    func testDispatchGroupSerial() {
        
        let maxNum = 3
        let dispatchGroup = DispatchGroup()

        // 定义一个函数来执行打印任务，避免重复代码
        func printNumbers(start: Int) {
            for i in start..<start + maxNum {
                print("\(start+i) execute")
            }
        }
        
        for i in 0..<maxNum {
            let queue = DispatchQueue(label: "DispatchQueue\(i)")
            print("\(queue.label) execute")
            dispatchGroup.enter()
            queue.async(group: dispatchGroup) {
                printNumbers(start: i * maxNum)
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
        }
        
        // 当所有任务完成后，在主队列上执行
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("main queue execute!")
        }

        // 如果你需要确保在继续之前所有任务都已完成，可以保留 wait
        // 如果确实需要同步等待，以下代码是可选的
        let result = dispatchGroup.wait(timeout: .now() + 5)
        if result == .success {
            print("所有任务在指定时间内完成")
        } else {
            print("等待超时，任务可能没有完成")
            // 这里可以添加超时的错误处理逻辑
        }
    }
}

