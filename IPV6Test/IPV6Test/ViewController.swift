//
//  ViewController.swift
//  IPV6Test
//
//  Created by ksnowlv on 2025/1/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urlString = "ccapi.api4basic.com"
        let usesIPv6 = isIPv6Address(urlString: urlString)
        print("Uses IPv6: \(usesIPv6)")
        
        let urlString1 = "baidu.com";
        let usesIPv61 = isIPv6Address(urlString: urlString1)
        print("Uses IPv6: \(usesIPv61)")
    }
    
    func isIPv6Address(urlString: String) -> Bool {
        guard let url = URL(string: urlString), let host = url.host else { return false }
        
        var hints = addrinfo(
            ai_flags: AI_NUMERICHOST, // 只解析数字地址
            ai_family: AF_UNSPEC,     // 不指定地址族，让系统自动选择
            ai_socktype: SOCK_STREAM,
            ai_protocol: IPPROTO_TCP,
            ai_addrlen: 0,
            ai_canonname: nil,
            ai_addr: nil,
            ai_next: nil
        )
        
        var info: UnsafeMutablePointer<addrinfo>? = nil
        let result = getaddrinfo(host, nil, &hints, &info)
        
        if result == 0 {
            var isIPv6 = false
            var nextInfo = info
            
            while nextInfo != nil {
                if nextInfo?.pointee.ai_family == AF_INET6 {
                    isIPv6 = true
                    break
                }
                nextInfo = nextInfo?.pointee.ai_next
            }
            
            freeaddrinfo(info)
            return isIPv6
        } else {
            return false
        }
    }

}

