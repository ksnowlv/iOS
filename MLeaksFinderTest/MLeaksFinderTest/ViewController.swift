//
//  ViewController.swift
//  MLeaksFinderTest
//
//  Created by ksnowlv on 2024/8/17.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let av:AViewController = AViewController.init(nibName: "AViewController", bundle: nil)
        
        self.navigationController?.pushViewController(av, animated: true
        )
    }
    
    @IBAction func handleHideAViewControllerEvent(_ sender: AnyObject) {
        
      
        
    }


}

