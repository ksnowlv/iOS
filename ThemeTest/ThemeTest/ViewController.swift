//
//  ViewController.swift
//  ThemeTest
//
//  Created by ksnowlv on 2024/10/16.
//

import UIKit
import SwiftTheme


class ViewController: UIViewController {
    @IBOutlet var textLabel:UILabel!
    @IBOutlet var testButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.theme_backgroundColor = ["#FF00FF", "#00FFFF"]
        
        textLabel.theme_textColor = ["#00FF", "#FF00"]
        testButton.theme_setTitleColor(["#00FFFF", "#FFF0"], forState: .normal)
        
//        ThemeManager.setTheme(index: 0) // ThemePickers will use the first parameter, eg. "#FFF" "day"
//        ThemeManager.setTheme(index: 1)
    }
    
    
    @IBAction func handleTestButtonEvent(_ sender: AnyObject) {
        
    }


}

