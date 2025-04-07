//
//  ViewController.swift
//  VPNTest
//
//  Created by ksnowlv on 2024/10/13.
//

import UIKit
import NetworkExtension


class ViewController: UIViewController {
    @IBOutlet var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func testVPN() {
        let manager = NEVPNManager.shared()
        
        // 加载配置
        manager.loadFromPreferences { (error) in
            if let error = error {
                print("加载VPN配置失败: \(error)")
                return
            }
         
            if  manager.isEnabled  {
                print("VPN配置无效或未启用")
                self.textLabel.text = "VPN配置无效或未启用"
                return
            }
            
            // 检查VPN状态
            let status = manager.connection.status
            switch status {
            case .connected:
                print("VPN is connected")
                self.textLabel.text = "VPN is connected"
            case .disconnected:
                print("VPN is disconnected")
                self.textLabel.text = "VPN is disconnected"
            case .connecting:
                print("VPN is connecting")
                self.textLabel.text = "VPN is connecting"
            case .disconnecting:
                print("VPN is disconnecting")
                self.textLabel.text = "VPN is disconnecting"
            case .invalid:
                print("VPN is invalid")
                self.textLabel.text = "VPN is invalid"
            case .reasserting:
                print("VPN is reasserting")
                self.textLabel.text = "VPN is reasserting"
            @unknown default:
                print("Unknown VPN status")
                self.textLabel.text = "Unknown VPN status"
            }
        }
    }

    
    @IBAction func handleGetVPNState(_ sender: AnyObject ) {
        self.testVPN()
    }
}

