//
//  ViewController.swift
//  Toast-SwiftTest
//
//  Created by ksnowlv on 2024/8/20.
//

import UIKit
import Toast_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction  func testBaseToast() {
        // basic usage
        self.view.makeToast("This is a piece of toast")

        // toast with a specific duration and position
        self.view.makeToast("This is a piece of toast", duration: 3.0, position: .top)
//
//        // toast presented with multiple options and with a completion closure
        self.view.makeToast("This is a piece of toast", duration: 2.0, point: CGPoint(x: 110.0, y: 210.0), title: "Toast Title", image: UIImage(named: "toast.png")) { didTap in
            if didTap {
                print("completion from tap")
            } else {
                print("completion without tap")
            }
        }

//         display toast with an activity spinner
        self.view.makeToastActivity(.center)

        // display any view as toast
//        self.view.showToast(nil)

        // immediately hides all toast views in self.view
//        self.view.hideAllToasts()
        
    }
    
    @IBAction func testOtherToast() {
        // create a new style
        var style = ToastStyle()

        // this is just one of many style options
        style.messageColor = .green

        // present the toast with the new style
        self.view.makeToast("This is a piece of toast", duration: 3.0, position: .bottom, style: style)

        // or perhaps you want to use this style for all toasts going forward?
        // just set the shared style and there's no need to provide the style again
        ToastManager.shared.style = style
        self.view.makeToast("This is a piece of toast ") // now uses the shared style

        // toggle "tap to dismiss" functionality
        ToastManager.shared.isTapToDismissEnabled = true

        // toggle queueing behavior
        ToastManager.shared.isQueueEnabled = true
    }


}

