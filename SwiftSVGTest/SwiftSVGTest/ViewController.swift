//
//  ViewController.swift
//  SwiftSVGTest
//
//  Created by ksnowlv on 2024/8/3.
//

import UIKit
import SwiftSVG

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testSVG()
    }
    
    func testSVG()  {
        
        let size = UIScreen.main.bounds.size
        let view = UIView(SVGNamed: "fistBump")
        view.frame = CGRect(x: 0, y: 80, width: size.width, height: 100)
        
        self.view.addSubview(view)
        
        let svgURL = URL(string: "https://openclipart.org/download/181651/manhammock.svg")!
        let hammock = UIView(SVGURL: svgURL) { (svgLayer) in
            svgLayer.fillColor = UIColor(red:0.52, green:0.16, blue:0.32, alpha:1.00).cgColor
            svgLayer.resizeToFit(self.view.bounds)
        }
        hammock.frame = CGRect(x: 0, y: 200, width: size.width, height: 60)
        self.view.addSubview(hammock)
        
        // Example
        let triangle = UIView(pathString: "M75 0 l75 200 L0 200 Z")
        triangle.frame = CGRect(x: 0, y: 580, width: size.width, height: 30)
        self.view.addSubview(triangle)
    }

}

