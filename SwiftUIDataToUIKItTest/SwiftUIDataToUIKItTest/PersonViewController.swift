//
//  PersonViewController.swift
//  SwiftUIDataToUIKItTest
//
//  Created by ksnowlv on 2024/10/7.
//

import UIKit

class PersonViewController: UIViewController {
    
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var ageLabel:UILabel!
    @IBOutlet var addressLabel:UILabel!
    @IBOutlet var yearLabel:UILabel!
    
    var person: Person? {
         didSet {
             updateUI() // 当person属性被设置时，更新UI
             print("Person property didSet called")
         }
     }
    
    var year: Int = 0 {
         didSet {
             updateUI() // 当person属性被设置时，更新UI
             print("Person property didSet called")
         }
     }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.updateUI()
    }
    
    func updateUI() {
        
        if(!self.isViewLoaded) {
            return
        }
        
        guard let person = person else { return }
        
        nameLabel.text = "Name: \(person.name)"
        ageLabel.text = "Age: \(person.age)"

        addressLabel.text = "Address: \(person.address)"
        addressLabel.numberOfLines = 0
        
        yearLabel.text = "year:\(year)"
    }
    
    @IBAction func handleYearChangeEvent(_ sender: AnyObject) {
        year += 10
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
