//
//  ViewController.swift
//  CronetTest
//
//  Created by ksnowlv on 2024/8/31.
//

import UIKit

class ViewController: UIViewController {

    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networkManager.testHTTP3Request()
    }


}

