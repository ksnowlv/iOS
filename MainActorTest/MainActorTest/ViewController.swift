//
//  ViewController.swift
//  MainActorTest
//
//  Created by ksnowlv on 2024/10/25.
//

import UIKit


@MainActor
struct MainActorStruct {
    var count = 0
    
//    func increment() async -> MainActorStruct {
//           var newStruct = self
//           newStruct.count += 1
//           print("Count is now \(newStruct.count)")
//           return newStruct
//       }
    
    mutating func increment()  {
          count += 1
          // 这里的代码将在主线程上执行
          print("Count is now \(count)")
      }
}

//func useMainActorStruct() {
//    var structInstance = MainActorStruct()
//    
//    Task {
//        await structInstance.increment()
//    }
//}


class ViewController: UIViewController {
    
    @IBOutlet var textLabel: UILabel!
    var countNumber: Int = 0
    var structInstance = MainActorStruct()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task {
            print("在结构体中使用 MainActor")
            structInstance.increment()
        }
        
        performTaskOnMainActor()
     
    }
   
    @MainActor
    func updateUI() async {
        textLabel.text = "current number:\(countNumber)"
    }
    
    
    @IBAction func handleTestMainActorEvent(_ sender: AnyObject) {
        Task {
            await fetchData()
            // 由于updateUI是@MainActor标记的方法，它会自动在主线程上执行
            // 使用 MainActor 在异步函数中,因此不需要使用await来调用它
            await updateUI()
        }
    }
    
    // fetchData 方法，假设它在后台线程获取数据,模拟异步获取数据
    func fetchData() async {
        countNumber += 1
        print("countNumber:\(countNumber)")
        // 数据获取逻辑完成后，可以在这里进行其他异步操作
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
    
    
    
    //使用 MainActor 在主线程上执行任务
    func performTaskOnMainActor()  {
        
        Task {
            await MainActor.run {
                // 在这里执行主线程上的任务,更新相关UI
                print("使用 MainActor 在主线程上执行任务")
                textLabel.text = "使用 MainActor 在主线程上执行任务";
            }
        }
    }

}

