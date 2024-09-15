//
//  ViewController.swift
//  SwiftRichStringTest
//
//  Created by ksnowlv on 2024/8/20.
//

import UIKit
import SwiftRichString

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testStyling()
        self.testXMLHTMLTag()
//        self.testNetImageLoad()
//        self.testImageLoad()
    }
    
    func testStyling() {
        let style = Style {
            $0.font = SystemFonts.AmericanTypewriter.font(size: 25) // just pass a string, one of the SystemFonts or an UIFont
            $0.color = "#0433FF" // you can use UIColor or HEX string!
            $0.underline = (.patternDot, UIColor.green)
            $0.alignment = .center
        }
        let attributedText = "Hello SwiftRichString".set(style: style) // et voilà!
        self.textLabel1.attributedText = attributedText
    }
    
    func testXMLHTMLTag() {
        let normal = Style {
            $0.font = SystemFonts.Helvetica_Light.font(size: 15)
            $0.color = UIColor.blue
            $0.backColor = UIColor.magenta
            $0.underline = (.patternDash, UIColor.green)
        }
                
        let bold = Style {
            $0.font = SystemFonts.Helvetica_Bold.font(size: 20)
            $0.color = UIColor.red
            $0.backColor = UIColor.yellow
        }
                
        let italic = normal.byAdding {
            $0.traitVariants = .italic
        }

        let myGroup = StyleXML(base: normal, ["bold": bold, "italic": italic])
        let str = "Hello <bold>SwiftRichString!</bold>. You're ready to <italic> play with us!</italic>"
        self.textLabel2?.attributedText = str.set(style: myGroup)
    }
    
    func testNetImageLoad() {
        
        let style = Style {
            $0.font = SystemFonts.Helvetica_Light.font(size: 15)
            $0.color = UIColor.green
        }
        
        guard let remoteTextAndImage = AttributedString(imageURL: "https://gips2.baidu.com/it/u=1674525583,3037683813&fm=3028&app=3028&f=JPEG&fmt=auto?w=1024&h=1024") else { return  }

        // You can now compose it with other attributed or simple string
        let finalString = "...".set(style: style) + remoteTextAndImage + " some other text"
        self.textLabel3.attributedText = finalString
    }
    
    func testImageLoad() {
        
        let taggedText = """
          Some text and this image:
          <img named="rocket" rect="0,-50,30,30"/>
          
          This other is loaded from remote URL:
          <img url="https://www.macitynet.it/wp-content/uploads/2018/05/video_ApplePark_magg18.jpg"/>
        """
        
        let normal = Style {
            $0.font = SystemFonts.Helvetica_Light.font(size: 15)
            $0.color = UIColor.blue
            $0.backColor = UIColor.magenta
            $0.underline = (.patternDash, UIColor.green)
        }

        self.textView?.attributedText = taggedText.set(style: normal)
    }


}

