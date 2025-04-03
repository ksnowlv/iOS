//
//  ViewController.swift
//  TextAttributesTest
//
//  Created by Mac on 2024/12/5.
//

import UIKit
import TextAttributes

class ViewController: UIViewController {
    @IBOutlet var label:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let attrs = TextAttributes()
            .font(name: "HelveticaNeue", size: 16)
            .foregroundColor(white: 0.2, alpha: 1)
            .backgroundColor(UIColor.black)
            .lineHeightMultiple(1.5)
            .underlineStyle(.single)

        let textAttributes =  NSAttributedString(string: "The quick brown fox jumps over the lazy dog", attributes: attrs)
        label.attributedText = textAttributes
       
    }


}

