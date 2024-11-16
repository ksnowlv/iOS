//
//  BClass.swift
//  NotificationCenterTest
//
//  Created by ksnowlv on 2024/9/30.
//

import UIKit

class BClass: NSObject {
    
    let myNotification = Notification.Name("myNotification")
    
    override init() {
        super.init()
        // 添加观察者
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: myNotification, object: nil)

    }
    
    // 处理通知的方法
    @objc func handleNotification(notification: Notification) {
        // 处理通知逻辑
        print("---BClass handleNotification \(notification.object) ")
    }

    
    func test() {
        // 发布通知
        NotificationCenter.default.post(name: myNotification, object: "BClass test")
    }
    
    deinit {
//        NotificationCenter.default.removeObserver(self)
        print("---BClass deinit")
    }
  
    
    

}
