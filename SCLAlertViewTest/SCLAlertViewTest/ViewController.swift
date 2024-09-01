//
//  ViewController.swift
//  SCLAlertViewTest
//
//  Created by ksnowlv on 2024/8/20.
//

import UIKit
import SCLAlertView

class ViewController: UIViewController {
    
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SCLAlertView().showInfo("Important info", subTitle: "You are great")
   
    }
    
    @IBAction func handleShowInfoEvent(_ sender: AnyObject) {
        
        
        switch self.count {
        case 0:
            SCLAlertView().showInfo("Important info", subTitle: "You are great")
            
        case 1:
            
            SCLAlertView().showError("Hello Error", subTitle: "This is a more descriptive error text.") // Error
            
        case 2:
            
            SCLAlertView().showNotice("Hello Notice", subTitle: "This is a more descriptive notice text.") // Notice
            
        case 3:
            
            SCLAlertView().showWarning("Hello Warning", subTitle: "This is a more descriptive warning text.") // Warning
            
        case 4:
            SCLAlertView().showEdit("Hello Edit", subTitle: "This is a more descriptive info text.") //
           
        case 5:
            SCLAlertView().showWait("Hello wait", subTitle: "This is a more descriptive info text.") //
            
        case 6:
            SCLAlertView().showSuccess("Hello Success", subTitle: "This is a more descriptive info text.") //
            
        case 7:
            SCLAlertView().showTitle("Congratulations", subTitle: "Operation successfully completed.", timeout: SCLAlertView.SCLTimeoutConfiguration(timeoutValue: 2, timeoutAction: {
                print("timeoutAction is action")
            }), completeText: "OK", style: SCLAlertViewStyle.question)
        default:
            print("-----support----")
            
        }
        
        self.count += 1
        
        if self.count == 7 {
            self.count = 0
        }
        

    }
    
    @IBAction func handleCustomAppearanceEvent(_ sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
        )

        let alert = SCLAlertView(appearance: appearance)
        
        alert.showInfo("Important info", subTitle: "You are great")
    }
    
    @IBAction func handleAddbuttonsEvent(_ sender: AnyObject) {
   
        let alertView = SCLAlertView()
        alertView.addButton("First Button", target:self, selector:Selector(("firstButton")))
        alertView.addButton("Second Button") {
            print("Second button tapped")
        }
        alertView.showSuccess("Button View", subTitle: "This alert view has buttons")
    }
    
    @IBAction func handleHideDefaultCloseButtonEvent(_ sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.showSuccess("No button", subTitle: "You will have hard times trying to close me")
   
    }
    
    @IBAction func handleHideAlertIconEvent(_ sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.showSuccess("No icon", subTitle: "This is a clean alert without Icon!")
   
    }
    
    @IBAction func handleUseCustomIconEvent(_ sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: true
        )
        let alertView = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "IconImage") //Replace the IconImage text with the image name
        alertView.showInfo("Custom icon", subTitle: "This is a nice alert with a custom icon you choose", circleIconImage: alertViewIcon)
   
    }
    
    @IBAction func handleAddTextFieldsEvent(_ sender: AnyObject) {
        // Add a text field
        let alert = SCLAlertView()
        let txt = alert.addTextField("Enter your name")
        alert.addButton("Show Name") {
            print("Text value: \(txt.text)")
        }
        alert.showEdit("Edit View", subTitle: "This alert view shows a text box")

   
    }
    
    @IBAction func handleUseCustomSubviewInsteadOfSubtitleEvent(_ sender: AnyObject) {
        // Example of using the view to add two text fields to the alert
        // Create custom Appearance Configuration
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false,
            dynamicAnimatorActive: true
        )

        // Initialize SCLAlertView using custom Appearance
        let alert = SCLAlertView(appearance: appearance)

        // Creat the subview
        let subview = UIView(frame: CGRect(x: 0,y: 0,width: 216,height: 70))
        let x = (subview.frame.width - 180) / 2

        // Add textfield 1
        let textfield1 = UITextField(frame: CGRect(x: x,y: 10,width: 180,height: 25))
        textfield1.layer.borderColor = UIColor.green.cgColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Username"
        textfield1.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield1)

        // Add textfield 2
        let textfield2 = UITextField(frame: CGRect(x: x,y: textfield1.frame.maxY + 10,width: 180,height: 25))
        textfield2.isSecureTextEntry = true
        textfield2.layer.borderColor = UIColor.blue.cgColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield1.layer.borderColor = UIColor.blue.cgColor
        textfield2.placeholder = "Password"
        textfield2.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield2)

        // Add the subview to the alert's UI property
        alert.customSubview = subview
        _ = alert.addButton("Login") {
            print("Logged in")
        }

        // Add Button with visible timeout and custom Colors
        let showTimeout = SCLButton.ShowTimeoutConfiguration(prefix: "(", suffix: " s)")
        _ = alert.addButton("Timeout Button", backgroundColor: UIColor.brown, textColor: UIColor.yellow, showTimeout: showTimeout) {
            print("Timeout Button tapped")
        }

        let timeoutValue: TimeInterval = 10.0
        let timeoutAction: SCLAlertView.SCLTimeoutConfiguration.ActionType = {
            print("Timeout occurred")
        }

        _ = alert.showInfo("Login", subTitle: "", timeout: SCLAlertView.SCLTimeoutConfiguration(timeoutValue: timeoutValue, timeoutAction: timeoutAction))
   
    }


}

