//
//  ViewController.swift
//  SwiftyMarkdownTest
//
//  Created by ksnowlv on 2024/8/20.
//

import UIKit
import SwiftyMarkdown

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel:UILabel?
    @IBOutlet weak var textView : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testMarkdown()
    }
    
    func testMarkdown()   {
//        Read Markdown from a text string...

        let md = SwiftyMarkdown(string: "I'm a *single* line **string**. How do I look?")
        self.myLabel?.attributedText = md.attributedString()

    }
    
    
    @IBAction func reloadText( _ sender : UIButton? ) {
                
        self.textView.dataDetectorTypes = UIDataDetectorTypes.all
        
        if let url = Bundle.main.url(forResource: "example", withExtension: "md"),
           let md = SwiftyMarkdown(url: url) {
            
             if let content = try? String(contentsOf: url) {
                 print("example.md ontent:\(content)")
             }
            
            md.h2.fontName = "AvenirNextCondensed-Bold"
            md.h2.color = UIColor.blue
            md.h2.alignment = .center
            
            md.code.fontName = "CourierNewPSMT"
            

            if #available(iOS 13.0, *) {
                md.strikethrough.color = .tertiaryLabel
            } else {
                md.strikethrough.color = .lightGray
            }
            
            md.blockquotes.fontStyle = .italic
        
            md.underlineLinks = true
            
            self.textView.attributedText = md.attributedString()

        } else {
            fatalError("Error loading file")
        }
    }
}

