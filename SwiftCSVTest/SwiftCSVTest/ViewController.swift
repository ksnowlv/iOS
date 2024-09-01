//
//  ViewController.swift
//  SwiftCSVTest
//
//  Created by ksnowlv on 2024/8/20.
//

import UIKit

import SwiftCSV


class ViewController: UIViewController {
    
    static let csvFileName = "hot"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.testCSVContentLoad()
        self.testCSVPartContentLoad()
    }
    
    func testCSVContentLoad() {
        
        do {
            // As a string, guessing the delimiter
            //从字符串字面量来创建一个CSV对象
            let csv: CSV = try CSV<Named>(string: "id,name,age\n1,Alice,18")
            
            showCSV(csv)
            
            // Specifying a custom delimiter
            //如果需要自定义分隔符,创建一个CSV对象,
            let tsv: CSV = try CSV<Enumerated>(string: "id\tname\tage\n1\tAlice\t18", delimiter: .tab)
            
           
            // From a file (propagating error during file loading)
            //从文件中加载
            if let path = Bundle.main.path(forResource:"hot",ofType:"csv") {
                print("csv path:\(path)")
                let csvFile: CSV = try CSV<Named>(url: URL(fileURLWithPath: path))
                showCSV(csvFile)
                
            }
            
            // From a file inside the app bundle, with a custom delimiter, errors, and custom encoding.
            // Note the result is an optional.
            let resource: CSV? = try CSV<Named>(
                name: "users",
                extension: "tsv",
                bundle: .main,
                delimiter: .character("🐠"),  // Any character works!
                encoding: .utf8)
            
        } catch {
            // Catch errors from trying to load files
            print("csv error:\(error)")
        }
    }
    
    func testCSVPartContentLoad() {
        
        do {
            //从文件中加载
            if let path = Bundle.main.path(forResource:"hot",ofType:"csv") {
                print("csv path:\(path)")
                
                let namedCSV  = try NamedCSV(url: URL(fileURLWithPath: path))
                
                //抽取关键词这列数据
                if let keyColumnData = namedCSV.columns?["关键词"] {
                    // 输出读取到的"关键词"列的数据
                    print("---关键词---")
                    for value in keyColumnData {
                        print(value)
                    }
                }
                
                //抽取描述这列数据
                if let desciptionColumnData = namedCSV.columns?["描述"] {
                    // 输出读取到的"描述"列的数据
                    print("---描述---")
                    for value in desciptionColumnData {
                        print(value)
                    }
                }
                
            }
            
        } catch {
            // Catch errors from trying to load files
            print("csv error:\(error)")
        }
    }
    
    func showCSV(_ csv: NamedCSV)  {
        
        print("csv header : \(csv.header)")
        
        let rows = csv.rows
        print("----csv rows-----")
        for (index, row) in rows.enumerated() {
            print("Row \(index): \(row)")
        }
        
        print("csv rows : \(csv.rows)")
        
        if let columns = csv.columns {
            print("----csv columns-----")
            for  item in columns {
                print(" column:\(item)")
                
            }
        }
    }
    
}

