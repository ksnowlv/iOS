//
//  AppDelegate.swift
//  PrivacyContextDemo
//
//  Created by kevinxu on 2024/10/8.
//

import UIKit
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate, URLSessionTaskDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    let vc = UIViewController()
    let session = URLSession.shared
    
    let cf_Endpoints: Array<NWEndpoint> = [NWEndpoint.hostPort(host: "1.1.1.1", port: 443),
                                          NWEndpoint.hostPort(host: "1.0.0.1", port: 443),
                                          NWEndpoint.hostPort(host: "2606:4700:4700::1111", port: 443),
                                          NWEndpoint.hostPort(host: "2606:4700:4700::1001", port: 443)]
    
    let ali_Endpoints: Array<NWEndpoint> = [NWEndpoint.hostPort(host: "223.5.5.5", port: 443),
                                            NWEndpoint.hostPort(host: "223.6.6.6", port: 443),
                                            NWEndpoint.hostPort(host: "2400:3200::1", port: 443),
                                            NWEndpoint.hostPort(host: "2400:3200:baba::1", port: 443)]
    
    let sll_Endpoints: Array<NWEndpoint> = [NWEndpoint.hostPort(host: "101.226.4.6", port: 443),
                                            NWEndpoint.hostPort(host: "218.30.118.6", port: 443),
                                            NWEndpoint.hostPort(host: "123.125.81.6", port: 443),
                                            NWEndpoint.hostPort(host: "140.207.198.6", port: 443)]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window?.frame = UIScreen.main.bounds
        self.window?.rootViewController = self.vc
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        print("launched")
        
        let cfButton = UIButton(frame: CGRect(x: 20, y: 100, width: 90, height: 40))
        cfButton.layer.borderWidth = 1
        cfButton.layer.borderColor = UIColor.red.cgColor
        cfButton.setTitle("Cloudflare", for: .normal)
        cfButton.setTitleColor(UIColor.black, for: .normal)
        cfButton.addTarget(self, action: #selector(cfButtonClicked), for: .touchUpInside)
        self.vc.view.addSubview(cfButton)
        
        let aliButton = UIButton(frame: CGRect(x: 20, y: 170, width: 90, height: 40))
        aliButton.layer.borderWidth = 1
        aliButton.layer.borderColor = UIColor.red.cgColor
        aliButton.setTitle("Alibaba", for: .normal)
        aliButton.setTitleColor(UIColor.black, for: .normal)
        aliButton.addTarget(self, action: #selector(aliButtonClicked), for: .touchUpInside)
        self.vc.view.addSubview(aliButton)
        
        let sllButton = UIButton(frame: CGRect(x: 20, y: 240, width: 90, height: 40))
        sllButton.layer.borderWidth = 1
        sllButton.layer.borderColor = UIColor.red.cgColor
        sllButton.setTitle("360", for: .normal)
        sllButton.setTitleColor(UIColor.black, for: .normal)
        sllButton.addTarget(self, action: #selector(sllButtonClicked), for: .touchUpInside)
        self.vc.view.addSubview(sllButton)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
            
            
        })
        
        return true
    }
    
    @objc func cfButtonClicked() {
        if let url = URL(string: "https://cloudflare-dns.com/dns-query") {
            NWParameters.PrivacyContext.default.requireEncryptedNameResolution(true, fallbackResolver: .https(url, serverAddresses: cf_Endpoints))
        }
        sendRequest()
    }
    
    @objc func aliButtonClicked() {
        if let url = URL(string: "https://157374.alidns.com/dns-query") {
            NWParameters.PrivacyContext.default.requireEncryptedNameResolution(true, fallbackResolver: .https(url, serverAddresses: ali_Endpoints))
        }
        sendRequest()
    }
    
    @objc func sllButtonClicked() {
        if let url = URL(string: "https://doh.360.cn") {
            NWParameters.PrivacyContext.default.requireEncryptedNameResolution(true, fallbackResolver: .https(url, serverAddresses: sll_Endpoints))
        }
        sendRequest()
    }
    
    func sendRequest() {
        guard let url = URL(string: "https://ccapi.lbk.world/lbk-side-center/config/app/switch") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("ccapi.lbk.world", forHTTPHeaderField: "Host")
        let task = self.session.dataTask(with: request) { data, response, error in
            if let e = error {
                print(e)
                return
            }
            
            guard let _data = data,
                  let obj = try? JSONSerialization.jsonObject(with: _data) else { return }
            
            print(obj)
        }
        task.delegate = self
        task.resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        if let pro = metrics.transactionMetrics.first?.domainResolutionProtocol {
            var result = "unknown"
            switch pro {
            case .https:
                result = "https"
            case .tcp:
                result = "tcp"
            case .udp:
                result = "udp"
            default:
                result = "unknown"
            }
            DispatchQueue.main.async {
                let alert = UIAlertController(title: result, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "close", style: .destructive, handler: { [weak alert] action in
                    alert?.dismiss(animated: true)
                }))
                self.window?.rootViewController?.present(alert, animated: true)
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

