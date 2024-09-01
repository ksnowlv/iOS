//
//  NetworkSessionDelegate.swift
//  NetMetricsTest
//
//  Created by ksnowlv on 2024/7/12.
//

import Foundation

class NetworkSessionDelegate: NSObject, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        // 这里处理收集到的 metrics
     
        print("网络任务实例化和完成之间的时间间隔（taskInterval）: \(String(describing: metrics.taskInterval))")
        print("网络任务重定向次数（redirectCount）: \(String(describing: metrics.redirectCount))")
        for metric in metrics.transactionMetrics {
            handleTransactionMetric(metric)
        }
    }
    
    private func handleTransactionMetric(_ metric: URLSessionTaskTransactionMetrics) {
        
        print("----------网络时间方面-----")
        print("开始获取资源的时间（fetchStartDate）: \(metric.fetchStartDate)")
        print("域名解析开始的时间（domainLookupStartDate）: \( metric.domainLookupStartDate)")
        print("域名解析结束的时间（domainLookupEndDate）: \(String(describing: metric.domainLookupEndDate))")
        print("开始建立TCP连接的时间(connectStartDate): \(String(describing: metric.connectStartDate))")
        print("完成建立TCP连接的时间(connectEndDate): \(String(describing: metric.connectEndDate))")
        print("开始TLS安全握手的时间（secureConnectionStartDate）: \(String(describing: metric.secureConnectionStartDate))")
        print("完成TLS安全握手的时间（secureConnectionEndDate）: \(String(describing: metric.secureConnectionEndDate))")
        print("请求发送的时间（requestStartDate）: \(String(describing: metric.requestStartDate))")
        print("请求结束的时间（requestEndDate）: \(String(describing: metric.requestEndDate))")
        print("收到响应的第一个字节的时间（responseStartDate）: \(String(describing: metric.responseStartDate))")
        print("收到响应的最后一个字节的时间（responseEndDate）: \(String(describing: metric.responseEndDate))")
        
        if let domainLookupEndDate = metric.domainLookupEndDate,let domainLookupStartDate = metric.domainLookupStartDate {
           let domainLookupDuration = domainLookupEndDate.timeIntervalSince(domainLookupStartDate)
           print("域名解析时长：\(domainLookupDuration * 1000) 秒")
        } else {
           print("域名解析时长无法计算")
        }
        
        
        if let tcpConnectionEndDate = metric.connectEndDate,let tcpConnectionStartDate = metric.connectStartDate {
           let tcpConnectionDuration = tcpConnectionEndDate.timeIntervalSince(tcpConnectionStartDate)
           print("TCP连接时长：\(tcpConnectionDuration) 秒")
        } else {
           print("TCP连接时长无法计算")
        }
        
        if let tlsHandshakeEndDate = metric.secureConnectionEndDate,let tlsHandshakeStartDate = metric.secureConnectionStartDate {
           let tlsHandshakeDuration = tlsHandshakeEndDate.timeIntervalSince(tlsHandshakeStartDate)
           print("TLS安全握手时长：\(tlsHandshakeDuration) 秒")
        } else {
           print("TLS安全握手时长无法计算")
        }

        
        
        if let responseEndDate = metric.responseEndDate,let requestStartDate = metric.requestStartDate {
           let requestResponseDuration = responseEndDate.timeIntervalSince(requestStartDate)
           print("请求响应时长【从请求开发到请求结束】：\(requestResponseDuration) 秒")
        } else {
           print("请求响应时长无法计算")
        }

    
        
        if let connectionEndDate = metric.responseStartDate,let connectionStartDate = metric.responseStartDate {
           let connectionDuration = connectionEndDate.timeIntervalSince(connectionStartDate)
           print("响应时长【收到响应的第一个字节的时间到最后一个字节的时间】：\(connectionDuration) 秒")
        } else {
           print("响应时长无法计算")
        }
        
        print("----------网络数据监控方面（iOS13+有效）-----")
        
        if #available(iOS 13.0, *) {
            print("iOS13+发送前编码之前请求体数据的大小(countOfRequestBodyBytesBeforeEncoding):\(metric.countOfRequestBodyBytesBeforeEncoding)")
            print("iOS13+发送的请求头字节数(countOfRequestHeaderBytesSent):\(metric.countOfRequestHeaderBytesSent)")
            print("iOS13+发送前编码之前请求体数据的大小(countOfResponseBodyBytesAfterDecoding):\(metric.countOfResponseBodyBytesAfterDecoding)")
            print("iOS13+传递给代理或完成处理程序的数据的大小(countOfResponseBodyBytesAfterDecoding):\(metric.countOfResponseBodyBytesAfterDecoding)")
            print("iOS13+接收的响应体字节数(countOfResponseBodyBytesReceived):\(metric.countOfResponseBodyBytesReceived)")
            print("iOS13+接收的响应头字节数(countOfResponseHeaderBytesReceived):\(metric.countOfResponseHeaderBytesReceived)")
        }
            
        print("----------网络协议基础属性方面-----")
        
        print("使用的网络协议名称(networkProtocolName): \(metric.networkProtocolName ?? "Unknown")")
        
        if #available(iOS 13, *) {
            print("iOS13+远程接口的IP地址(remoteAddress): \(String(describing: metric.remoteAddress))")
            print("iOS13 +本地接口的 IP 地址(localAddress): \(String(describing: metric.localAddress))")
        }
        
        print("远程接口的端口号(remotePort): \(String(describing: metric.remotePort))")
        print("本地接口的端口号(localPort): \(String(describing: metric.localPort))")
        print("TLS密码套件(negotiatedTLSCipherSuite): \(String(describing: metric.negotiatedTLSCipherSuite?.rawValue))")
        print("TLS协议版本(negotiatedTLSProtocolVersion): \(String(describing: metric.negotiatedTLSProtocolVersion?.rawValue))")
        print("连接是否经由蜂窝网络(isCellular): \(metric.isCellular)")
        print("连接是否经由高成本接口(isExpensive): \(metric.isExpensive)")
        print("连接是否经由受限制的接口(isConstrained): \(metric.isConstrained)")
        print("是否使用了代理连接来获取资源(isProxyConnection): \(metric.isProxyConnection)")
        print("任务是否使用了重用连接来获取资源(isReusedConnection): \(metric.isReusedConnection)")
        print("连接是否成功协商了多路径协议(isMultipath): \(metric.isMultipath)")
        print("标识资源的加载方式(resourceFetchType): \(metric.resourceFetchType.rawValue)")

        
        if #available(iOS 14, *) {
            
//        case udp = 1 /* Resolution used DNS over UDP. */
//
//        case tcp = 2 /* Resolution used DNS over TCP. */
//
//        case tls = 3 /* Resolution used DNS over TLS. */
//
//        case https = 4 /* Resolution used DNS over HTTPS. */
            
            switch(metric.domainResolutionProtocol) {
            case .unknown:
                print("iOS14+ 域名解析所使用的协议(domainResolutionProtocol): unknown")
                break
            case.udp:
                print("iOS14+ 域名解析所使用的协议(domainResolutionProtocol): 表示使用了udp 协议进行域名解析")
                break
            case .tcp:
                print("iOS14+ 域名解析所使用的协议(domainResolutionProtocol): 表示使用了tcp 协议进行域名解析")
            case .tls:
                print("iOS14+ 域名解析所使用的协议(domainResolutionProtocol):  表示使用了tls协议进行域名解析")
            case .https:
                print("iOS14+ 域名解析所使用的协议(domainResolutionProtocol): 表示使用了https 协议进行域名解析")
            @unknown default:
                print("iOS14+ 域名解析所使用的协议(domainResolutionProtocol): unknown")
            }
            
           
        }
        
        print("request url:\(String(describing: metric.request.url))")
        print("request httpMethod:\(String(describing: metric.request.httpMethod))")
        print("request timeoutInterval:\(metric.request.timeoutInterval)")
        print("-----request allHTTPHeaderFields---\n\(String(describing: metric.request.allHTTPHeaderFields?.debugDescription))\n-----request allHTTPHeaderFields end-----")
        print("request httpBody:\(String(describing: metric.request.httpBody))")
        
        let httpURLResponse:HTTPURLResponse? = metric.response as? HTTPURLResponse ?? nil
        
        print("response statusCode:\(String(describing: httpURLResponse?.statusCode))")
        print("-----response allHeaderFields:\n\(String(describing: httpURLResponse?.allHeaderFields))\n-----response allHeaderFields end-----")
        
    }
}
