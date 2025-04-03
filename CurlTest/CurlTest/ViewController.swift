//
//  ViewController.swift
//  CurlTest
//
//  Created by Mac on 2025/2/11.
//

import UIKit
import SwiftyCurl

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testCurl()
    }
    
    func testCurl() {
        print(SwiftyCurl.libcurlVersion)
        
        let curl = SwiftyCurl()
        curl.followLocation = true
        curl.queue = .global(qos: .background)
        curl.verbose = true
        
        print("SwiftyCurl allowedProtocols\(curl.allowedProtocols)")
        
        let progress = Progress()
        let observation1 = progress.observe(\.fractionCompleted) { progress, _ in
            print("Progress1: \(progress.completedUnitCount) of \(progress.totalUnitCount) = \(progress.fractionCompleted)")
        }
        
        curl.perform(with: .init(url: .init(string: "https://ccapi-h3.ierpifvid.com/lbk-side-center/config/time")!), progress: progress) { data, response, error in
            //            print(String(data: data ?? .init(), encoding: .ascii) ?? "(nil)")
            
            if let response = response as? HTTPURLResponse {
                print("Response1: \(response.url?.absoluteString ?? "(nil)") \(response.statusCode)\nheaders: \(response.allHeaderFields)")
            }
            
            if let error = error {
                print("Error: \(error)")
            }
            
            observation1.invalidate()
        }
        
//        let task = curl.task(with: .init(url: .init(string: "https://baidu.com")!))
//        let observation2 = task?.progress.observe(\.fractionCompleted) { progress, _ in
//            print("Progress2: \(progress.completedUnitCount) of \(progress.totalUnitCount) = \(progress.fractionCompleted)")
//        }
//        
//        print("Ticket: \(task?.taskIdentifier ?? UInt.max)")
//        
//        task?.resume { data, response, error in
//            //            print(String(data: data ?? .init(), encoding: .ascii) ?? "(nil)")
//            
//            if let response = response as? HTTPURLResponse {
//                print("Response2: \(response.url?.absoluteString ?? "(nil)") \(response.statusCode)\nheaders: \(response.allHeaderFields)")
//            }
//            
//            if let error = error {
//                print("Error: \(error)")
//            }
//            
//            observation2?.invalidate()
//        }
    }
    
    
}

