//
//  ViewController.swift
//  KeychainAccessTest
//
//  Created by ksnowlv on 2024/8/21.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testKeychainAccess()
    }
    
    func testKeychainAccess() {
      
        //Create Keychain for Application Password
        let keychain1 = Keychain(service: "com.example.KeychainAccessTest")
        
        let keychain2 = Keychain(service: "com.example.github-token", accessGroup: "12ABCD3E4F.shared")
        
        print("keychain1:\(keychain1.description)")
        
        //        Create Keychain for Internet Password
        let keychain3 = Keychain(server: "https://github.com", protocolType: .https)
        
        let keychain4 = Keychain(server: "https://github.com", protocolType: .https, authenticationType: .htmlForm)
        
        let accountId = "accountId"
        
        // set key
        do {
            try keychain1.set("0abc_c03930-1908aiekd", key: accountId)
            print("set \(accountId) key")
        }
        catch let error {
            print(error)
        }
        
        //get key
        if let value = try? keychain1.get(accountId) {
            print("get \(value) for \(accountId)")
        } else {
            print("get key:\(accountId) not exist!")
        }
        
        // remove key
        do {
            try keychain1.remove(accountId)
            print("remove key: \(accountId)")
        } catch let error {
            print("remove error: \(error)")
        }
        
    }
}

