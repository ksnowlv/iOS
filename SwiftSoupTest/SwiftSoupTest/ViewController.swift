//
//  ViewController.swift
//  SwiftSoupTest
//
//  Created by ksnowlv on 2024/8/11.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testSwiftSoup()
    }
    
    func testSwiftSoup()  {
        let url = URL(string: "https://top.baidu.com/board?tab=realtime")!

        URLSession.shared.dataTask(with: url) {[weak self]  data, response, error in
            if let error = error {
                print("Error fetching HTML: \(error)")
                return
            }
            
            guard let strongSelf = self, data != nil  else {
                return
            }

            strongSelf.handleResponseData(data!)
         
        }.resume()
    }
    
    func handleResponseData(_ data: Data) {
        
        guard let resString = String(data: data, encoding: .utf8) else {
            return
        }
        
        do {
            let doc = try SwiftSoup.parse(resString)
            let  elements = try doc.getElementsByClass("category-wrap_iQLoo horizontal_1eKyQ")
            
            for element in elements {
                
                let titleEle = try element.select(".c-single-text-ellipsis")
                print("title:\(try titleEle.text())")
                                
                let descriptionElements: Elements = try element.select(".hot-desc_1m_jR")
                print("subTitle:\(String(describing: try descriptionElements.first()?.text()))")
            

                let contentEle = try element.select(".content_1YWBm")
                let links: Elements = try contentEle.select("a")
                let href = try links.first()?.attr("href")
                print("link: \(String(describing: href))")
                
                let hotIndexEle = try element.select(".hot-index_1Bl1a")
                print("hotIndex: \(try hotIndexEle.text())")
            }
          
        } catch {
            print("Error parsing HTML: \(error)")
        }
    }
}

