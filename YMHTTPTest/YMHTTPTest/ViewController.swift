//
//  ViewController.swift
//  YMHTTPTest
//
//  Created by ksnowlv on 2025/3/7.
//

import UIKit
import YMHTTP

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.testNetwork()
    }
    
    // 定义一个函数来执行网络请求
    func fetchData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // 创建URLSession数据任务
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 在闭包中调用完成处理程序
            completion(data, response, error)
        }
        // 启动任务
        task.resume()
    }
    
    func testNetwork() {
        let url = URL(string: "https://ccapi-h3.ierpifvid.com/lbk-side-center/config/time")!

        self.fetchData(from: url) { data, response, error in
            // 在主线程中处理结果
            DispatchQueue.main.async {
                if let error = error {
                    // 处理错误
                    print("Error fetching data: \(error.localizedDescription)")
                } else if let data = data {
                    // 处理数据
                    let dataString = String(data: data, encoding: .utf8)
                    print("Received data: \(dataString ?? "")")
                    
                    if let httpUrlResponse = response as? HTTPURLResponse {
                       let responseHeader =  httpUrlResponse.allHeaderFields
                        
                        print("responseHeader:\(responseHeader)")
                    }
                    
                    
                }
            }
        }
    }

}

