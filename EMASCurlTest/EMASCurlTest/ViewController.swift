//
//  ViewController.swift
//  EMASCurlTest
//
//  Created by Mac on 2025/4/3.
//

import UIKit
import EMASCurl


class MyDNSResolver: NSObject, EMASCurlProtocolDNSResolver {
    static func resolveDomain(_ domain: String) -> String? {
//        return "104.18.41.76,172.64.146.180"
        return nil
    }
}

class ViewController: UIViewController {
  
        static let url = "https://ccapi-h3.ierpifvid.com/lbk-side-center/config/time"
//    static let url: String = "https:///172.64.148.239/lbk-side-center/config/time"
//    static let url = "https://ccapi.api4basic.com/lbk-side-center/config/time"
    //172.64.146.180
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let  config = URLSessionConfiguration.default
//        EMASCurlProtocol .install(into: config)
        EMASCurlProtocol.setHTTPVersion(HTTPVersion.HTTP3)
        EMASCurlProtocol.setDNSResolver(MyDNSResolver.self)
        EMASCurlProtocol.setDebugLogEnabled(true)
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        
        
        var request = URLRequest(url: URL(string: ViewController.url)!, cachePolicy: .reloadIgnoringCacheData)
//        let host = "ccapi.api4basic.com"

//        request.setValue(host, forHTTPHeaderField: "Origin")
//        request.setValue(host, forHTTPHeaderField: "Referer")
//        request.setValue(host, forHTTPHeaderField: "Host")
        
        if #available(iOS 14.5, *) {
            request.assumesHTTP3Capable = true
        } else {
            // Fallback on earlier versions
        }
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("请求失败，错误信息: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("响应: \(httpResponse.debugDescription)")
            }
            
            if let data = data, let body = String(data: data, encoding: .utf8) {
                print("响应体: \(body)")
            }
        }
        
        dataTask.resume()
        
        
    }
}

