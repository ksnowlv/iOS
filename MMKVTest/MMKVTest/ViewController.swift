//
//  ViewController.swift
//  MMKVTest
//
//  Created by ksnowlv on 2024/8/6.
//

import UIKit
import MMKV

extension String {
    static func randomString(ofLength length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJ----*()_+%$#@!~`/.,<>?;'KLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map{ _ in letters.randomElement()! })
        return randomString
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        [MMKV initializeMMKV:nil];
        MMKV.initialize(rootDir: nil, logLevel: .none)
        
        self.testMMKV()
        
    }
    
    func testMMKV() {

        
        let IntKey = "myIntValue"
        
        let mmkv:MMKV? = MMKV.default() ?? nil
        
        var startTime = CFAbsoluteTimeGetCurrent()
        
        let loopNumber = 500
        for i in 0..<loopNumber {
            let key = "\(IntKey)-\(i)"
            let randomNumber = Int.random(in: 0...loopNumber)
            mmkv?.set(Int32(randomNumber),forKey:key)
        }
        
        var endTime = CFAbsoluteTimeGetCurrent()
        var mmkvDeltaTime = endTime - startTime
        print("---Int写入MMKV时间耗时为\(mmkvDeltaTime)秒")
        
        let userDefault = UserDefaults.standard
        startTime = CFAbsoluteTimeGetCurrent()
        
        for i in 0..<loopNumber {
            let key = "\(IntKey)-\(i)"
            let randomNumber = Int.random(in: 0...loopNumber)
            userDefault.setValue(Int32(randomNumber), forKey: key)
            userDefault.synchronize()
        }
       
        
        endTime = CFAbsoluteTimeGetCurrent()
        var userDefaultDeltaTime = endTime - startTime
        print("---Int写入userDefault时间耗时为\(userDefaultDeltaTime)秒")
        
        startTime = CFAbsoluteTimeGetCurrent()
        
    
        for i in 0..<loopNumber {
            let key = "\(IntKey)-\(i)"
            _ = mmkv?.int32(forKey: key)
        }
        
        endTime = CFAbsoluteTimeGetCurrent()
        mmkvDeltaTime = endTime - startTime
        print("---Int读取MMKV时间耗时为\(mmkvDeltaTime)秒")
        

        startTime = CFAbsoluteTimeGetCurrent()
        
        for i in 0..<loopNumber {
            let key = "\(IntKey)-\(i)"
            _ = userDefault.integer(forKey: key)
        }
        
        endTime = CFAbsoluteTimeGetCurrent()
        userDefaultDeltaTime = endTime - startTime
        print("---Int读取userDefault时间耗时为\(userDefaultDeltaTime)秒")
        
        let json = "hello_demo"
        
        let testStringKey = "myString"
        startTime = CFAbsoluteTimeGetCurrent()

        for i in 0..<loopNumber {
            let key = "\(testStringKey)-\(i)"
//            let v = "\(json)-\(i)"
            let v = String.randomString(ofLength: 20)
            mmkv?.set(v,forKey:key)
//            print("mmkv写入\(i),\(v)")
        }
        endTime = CFAbsoluteTimeGetCurrent()
        var mmkvStringDeltaTime = endTime - startTime
        print("---字符串写入MMKV时间耗时为\(mmkvStringDeltaTime)秒")
        
        startTime = CFAbsoluteTimeGetCurrent()
        
        for i in 0..<loopNumber {
            let key = "\(testStringKey)-\(i)"
//            let v = "\(json)-\(i)"
            let v = String.randomString(ofLength: 20)
            userDefault.setValue(v, forKey: key)
//            print("userDefault写入\(i),\(v)")
            userDefault.synchronize()
        }
        
      
        endTime = CFAbsoluteTimeGetCurrent()
        var userDefaultStringDeltaTime = endTime - startTime
        print("---字符串写入userDefault时间耗时为\(userDefaultStringDeltaTime)秒")
        
        
        startTime = CFAbsoluteTimeGetCurrent()

        for i in 0..<loopNumber {
            let key = "\(testStringKey)-\(i)"
            let v = "\(json)-\(i)"
            _ = mmkv?.string(forKey: key, defaultValue: "")
        }
        endTime = CFAbsoluteTimeGetCurrent()
        mmkvStringDeltaTime = endTime - startTime
        print("---字符串读取MMKV时间耗时为\(mmkvStringDeltaTime)秒")
        
        startTime = CFAbsoluteTimeGetCurrent()
        
        for i in 0..<loopNumber {
            let key = "\(testStringKey)-\(i)"
            let v = "\(json)-\(i)"
            _  = userDefault.value(forKey: key)
        }
        
        endTime = CFAbsoluteTimeGetCurrent()
        userDefaultStringDeltaTime = endTime - startTime
        print("---字符串读取userDefault时间耗时为\(userDefaultStringDeltaTime)秒")
       
    }
}

