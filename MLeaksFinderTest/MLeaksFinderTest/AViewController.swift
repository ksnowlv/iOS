//
//  AViewController.swift
//  MLeaksFinderTest
//
//  Created by ksnowlv on 2024/8/17.
//

import UIKit

class AViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel?
    
    // 创建一个 Timer 实例
    var timer: Timer?
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            // 定时器触发时执行的代码
            self.updateUI()
        }
    }
    
    
    deinit {
        print("AViewController deinit")
    }
    
    // 更新 UI 的方法
    func updateUI() {
        // 在这里添加更新 UI 的代码
        
        self.count += 1
        self.textLabel?.text = "count:\(self.count)"
        print("定时器触发更新 UI \(self.count)")
    }

    
}
