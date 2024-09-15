//
//  ViewController.swift
//  ActiveLabelTest
//
//  Created by ksnowlv on 2024/8/20.
//

import UIKit
import ActiveLabel

class ViewController: UIViewController {
    
    @IBOutlet var textLabel: ActiveLabel!
    @IBOutlet var textLabel1: ActiveLabel!
    @IBOutlet var textLabel2: ActiveLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testActiveLable()
    }
    
    func testActiveLable() {
        
        ////base use
        self.textLabel.numberOfLines = 0
        self.textLabel.enabledTypes = [.mention, .hashtag, .url]
        self.textLabel.text = "This is a post with #hashtags and a @userhandle."
        self.textLabel.textColor = .magenta
        self.textLabel.handleHashtagTap { hashtag in
            print("Success. You just tapped the \(hashtag) hashtag")
        }
        
        //Custom types
        let customType = ActiveType.custom(pattern: "\\swith\\b") //Regex that looks for "with"
        self.textLabel1.enabledTypes = [.mention, .hashtag, .url]
        self.textLabel1.text = "This is a post with #hashtags and a @userhandle."
        self.textLabel1.customColor[customType] = UIColor.purple
        self.textLabel1.customSelectedColor[customType] = UIColor.green
        self.textLabel1.handleCustomTap(for: customType) { element in
            print("Custom type tapped: \(element)")
        }
        
        //Batched customization
        self.textLabel2.customize { label in
            label.text = "This is a post with #multiple #hashtags and a @userhandle.   https://github.com/optonaut/ActiveLabel.swift hello world"
        
            label.textColor = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
            label.hashtagColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
            label.mentionColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
            label.URLColor = UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1)
            label.handleMentionTap {
                print("Mention:\($0)")
            }
            label.handleHashtagTap {
                print("Hashtag:\($0)")
            }
            label.handleURLTap {
                print("URL:\($0.absoluteString)")
            }
        }
    }
    
    
    
    
}

