//
//  NetworkManager.swift
//  NetMetricsTest
//
//  Created by ksnowlv on 2024/8/2.
//

import Foundation
import os.log
import Cronet

class NetworkManager: NSObject, URLSessionDataDelegate {
    
    private var session: URLSession!
    
    func testHTTP3Request() {
        
        
        if self.session == nil {
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringCacheData
            config.allowsExpensiveNetworkAccess = true
            config.allowsCellularAccess = true
            Cronet.install(into: config)
        
            self.session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        }

    
       let url = URL(string: "https://cloudflare-quic.com")!
//       let url = URL(string: "https://litespeedtech.com")!
//        pgjones.dev
//        let url = URL(string: "https://quic.aiortc.org")!
//        aioquic
//        let url = URL(string: "https://pgjones.dev")!
//        let url = URL(string: "https://h2o.examp1e.net")!
//        let url = URL(string: "https://www.litespeedtech.com")!
//        let url = URL(string:"https://www.aliyun.com")!
//        let url = URL(string: "https://ccapi-h3.lbk.world")!
//        uuapi-h3.lbk.world
//        let url = URL(string: "https://uuapi-h3.lbk.world")!
//        let url = URL(string: "https://uuapi-h3.lbk.world/cfd/openApi/v1/pub/getTime")!
//        let url = URL(string: "https://ccapi-h3.lbk.world/cfd/openApi/v1/pub/getTime")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
        
        if #available(iOS 14.5, *) {
            request.assumesHTTP3Capable = false
            print("assumesHTTP3Capable:\(request.assumesHTTP3Capable)")
        }
      
        print("task will start, url: \(url.absoluteString)")
        self.session.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                print("task transport error \(error.domain) / \(error.code)")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("task response is invalid")
                return
            }
            
//            print("data:\(String.init(data: data, encoding: .utf8))")

            guard 200 ..< 300 ~= response.statusCode else {
                print("task response status code is invalid; received \(response.statusCode), but expected 2xx")
                return
            }
            print("task finished with status \(response.statusCode), bytes \(data.count)")
            
            if let httpResponse = response as? HTTPURLResponse {
                 for (key,value) in httpResponse.allHeaderFields {
                     print("\(key):\(value)")
                 }
             }
        }.resume()
        
    }
}


extension NetworkManager {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        let protocols = metrics.transactionMetrics.map { $0.networkProtocolName ?? "-" }
        print("protocols: \(protocols)")
    }
}
