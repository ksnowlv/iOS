//
//  ViewController.swift
//  SnapKitTest
//
//  Created by ksnowlv on 2024/8/11.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testSnapKit()
    }
    
    func testSnapKit() {
        if let superView: UIView = self.view {
            let box = UIView()
            box.backgroundColor = UIColor.green
            superView.addSubview(box)

            box.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(superView).offset(65)
                make.left.equalTo(superView).offset(20)
                make.bottom.equalTo(superView).offset(-20)
                make.right.equalTo(superView).offset(-20)
            }
        }
        
        if let superView: UIView = self.view {
            let box = UIView()
            box.backgroundColor = UIColor.blue
            superView.addSubview(box)

            box.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(superView).inset(UIEdgeInsets(
                    top: 95, left: 40, bottom: 40, right: 40))
            }
        }
    }
}

