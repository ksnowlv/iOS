//
//  AppDelegate.swift
//  CronetTest
//
//  Created by ksnowlv on 2024/8/31.
//

import UIKit
import Cronet

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.testConet()
        return true
    }
    
    
    
    func testConet() {
        
        Cronet.setHttp2Enabled(true)
        Cronet.setQuicEnabled(false)
        Cronet.setBrotliEnabled(true)
        //        Cronet.setAcceptLanguages("en-US,en")
        //        Cronet.setUserAgent("CronetTest/1.0.0.0", partial: false)
        //        Cronet.addQuicHint("www.chromium.org", port: 443, altPort: 443)
        let quicUrl = "cloudflare-quic.com"
        Cronet.addQuicHint(quicUrl, port: 443, altPort: 443)
        Cronet.setHttpCacheType(.disabled)
        Cronet.setMetricsEnabled(true)
        Cronet.setRequestFilterBlock { request in
            
            return false
        }
        
        
        Cronet.start()
        
        //Cronet.registerHttpProtocolHandler()
        
        let logFile = "cornetlog.log"
        let result  = Cronet.startNetLog(toFile: logFile, logBytes: false)
        let resultFile = Cronet.getNetLogPath(forFile: logFile)
        //        (NSString*)getNetLogPathForFile:(NSString*)fileName
        print("result:\(result),resultFile:\(resultFile!)")
        
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

