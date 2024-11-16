//
//  ViewController.swift
//  JsonTest
//
//  Created by ksnowlv on 2024/9/15.
//

import UIKit
import CryptoKit
import SwiftUI


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testSwiftUIIntoUIkit()
        
    }
    
    func testSwiftUIIntoUIkit() {
        //        let swiftUIView = SwiftUIView()
        //        let hostingController = UIHostingController(rootView: swiftUIView)
        //        addChild(hostingController)
        //
        //        let size =  UIScreen.main.bounds.size
        //
        //        hostingController.view.frame = CGRect(x: 0, y: size.height/2, width: size.width, height: size.height/2)
        //        self.view.addSubview(hostingController.view)
        //        hostingController.didMove(toParent: self)
        
        
        let swiftUIView = SwiftUIView()
        
        // 获取SwiftUI视图的UIkit视图表示
        let swiftUIUIKitView = UIHostingController(rootView: swiftUIView).view!
        
        // 将SwiftUI视图的UIKit表示添加到当前UIViewController的视图中
        swiftUIUIKitView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swiftUIUIKitView)
         swiftUIUIKitView.backgroundColor = UIColor.blue
        
      
        NSLayoutConstraint.activate([
            // 和父视图中心对齐
//            swiftUIUIKitView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            swiftUIUIKitView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            
            // 上下左右各留20的间距
            swiftUIUIKitView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            swiftUIUIKitView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            swiftUIUIKitView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            swiftUIUIKitView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            
        ])
    }
    
    @IBAction func testJsonUniqueIdentifierEvent() {
        
        let jsonString = """
                {
                    "id": 1,
                    "name": "Alice",
                    "email": "alice@example.com",
                    "profile": {
                        "bio": "Professional software developer with a passion for creating innovative solutions.",
                        "interests": ["coding", "reading", "traveling"],
                        "education": [
                            {
                                "institution": "University of Technology",
                                "degree": "Bachelor of Science in Computer Science",
                                "graduationYear": 2015
                            }
                        ],
                        "experience": [
                            {
                                "company": "Tech Innovators Inc.",
                                "title": "Senior Software Engineer",
                                "startDate": "2016-05-15",
                                "endDate": "2020-01-10"
                            },
                            {
                                "company": "NextGen Solutions",
                                "title": "Lead Developer",
                                "startDate": "2020-02-01",
                                "endDate": "Present"
                            }
                        ]
                    }
                }
                
                """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("error:\(NSError(domain: "Error converting string to Data for jsonDataHash", code: -3))")
            return
        }
        
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                let uniqueIdentifier = generateJsonUniqueIdentifier(for: jsonObject)
                print("---uniqueIdentifier:\(uniqueIdentifier)")
                let sha256Res =  HashAlgorithms.sha256(hashString: uniqueIdentifier)
                print("***sha256Res:\(sha256Res)")
            } else {
                
                print("Error converting JSON object to dictionary ")
            }
        } catch {
            print("Error converting string to JSON object : \(error)")
        }
    }
    
    /// 递归 生成唯一标识符
    /// - Parameters:
    ///   - json: json对象
    ///   - parent: 父结点串
    /// - Returns: 字符串
    func generateJsonUniqueIdentifier(for json: Any, parent: String? = nil) -> String {
        var uniqueIdentifier = parent ?? ""
        
        switch json {
        case let json as [String: Any]:
            //必须进行json对象key的排序
            json.keys.sorted().forEach { key in
                uniqueIdentifier += generateJsonUniqueIdentifier(for: json[key] as Any, parent: "\(key)")
            }
        case let json as [Any]:
            json.enumerated().forEach { index, value in
                uniqueIdentifier += generateJsonUniqueIdentifier(for: value, parent: index.description)
            }
        case let json as String:
            uniqueIdentifier += json
        case let json as Int:
            uniqueIdentifier += "\(json)"
        case let json as Bool:
            uniqueIdentifier += "\(json)"
            
        case let json as Double:
            uniqueIdentifier += "\(json)"
        case let json as Float:
            uniqueIdentifier += "\(json)"
        case let json as Date:
            uniqueIdentifier += "\(json.timeIntervalSince1970)"
        case let json as URL:
            uniqueIdentifier += json.absoluteString
            
        default:
            uniqueIdentifier += "UnknownType"
        }
        
        return uniqueIdentifier
    }
}



