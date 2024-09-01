//
//  AppDelegate.swift
//  SwiftyBeaverTest
//
//  Created by ksnowlv on 2024/8/22.
//

import UIKit
import SwiftyBeaver
let log = SwiftyBeaver.self


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.testLog()
        return true
    }
    
    func testLog() {
        let console = ConsoleDestination()  // log to Xcode Console
        let file = FileDestination()  // log to default swiftybeaver.log file

        // use custom format and set console output to short time, log level & message
        console.format = "$DHH:mm:ss$d $L $M"
        // or use this for JSON output: console.format = "$J"

        console.levelString.verbose = "💜 VERBOSE"
        console.levelString.debug = "💚 DEBUG"
        console.levelString.info = "💙 INFO"
        console.levelString.warning = "💛 WARNING"
        console.levelString.error = "❤️ ERROR"
        

        // add the destinations to SwiftyBeaver
        log.addDestination(console)
        log.addDestination(file)
      
        
        print("logfile path:\(file.logFileURL)")

        // Now let’s log!
        log.verbose("This is a log message for verbose ")  // prio 1, VERBOSE in silver
        log.debug("This is a log message for debug")  // prio 2, DEBUG in green
        log.info("This is a log message for info")   // prio 3, INFO in blue
        log.warning("This is a log message for warning")  // prio 4, WARNING in yellow
        log.error("This is a log message for error!")  // prio 5, ERROR in red

        // log anything!
        log.verbose(123)
        log.info(-123.45678)
        log.warning(Date())
        log.error(["I", "like", "logs!"])
        log.error(["name": "Mr Beaver", "address": "7 Beaver Lodge"])

        // optionally add context to a log message
        console.format = "$L: $M $X"
        log.debug("the boy age is ", context: 123)  // "DEBUG: age 123"
        log.info("user data:", context: [1, "name:snow", 2, "address:beijing", "phone:8888888"]) // "INFO: 
        
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

