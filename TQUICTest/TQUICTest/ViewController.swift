//
//  ViewController.swift
//  TQUICTest
//
//  Created by ksnowlv on 2024/8/24.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let logLevel = QUIC_LOG_LEVEL_TRACE
        
        print("logleve:\(logLevel)")
        
        let http3Status = HTTP3_NO_ERROR
        
        print("http3Status:\(http3Status)")
        
        let config = http3_config_new()
        
//        struct http3_conn_t *http3_conn_new(struct quic_conn_t *quic_conn, struct http3_config_t *config);
        
        
    }
    
//    // 在Swift代码中调用C函数
//    func createHttp3Config() -> UnsafeMutablePointer<http3_config_t>? {
//        return http3_config_new()
//    }


    


}

