//
//  ViewController.swift
//  NukeTest
//
//  Created by ksnowlv on 2024/8/11.
//

import UIKit
import Nuke

class ViewController: UIViewController {
    
    @IBOutlet weak var imageViewOne:UIImageView!
    @IBOutlet weak var imageViewTwo:UIImageView!
    @IBOutlet weak var imageViewThree:UIImageView!
    @IBOutlet weak var imageViewFour:UIImageView!
    @IBOutlet weak var imageViewFive:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Nuke.loadImage(with: URL(string: "https://gips3.baidu.com/it/u=1039279337,1441343044&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f1024_1024")!, into: self.imageViewOne)
      
        
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "placeholder"),
            transition: .fadeIn(duration: 0.33), // 使用正确的 ImageTransition
            failureImage: UIImage(named: "failure_image"),
            contentModes: .init(
                success: .scaleAspectFill,
                failure: .center,
                placeholder: .center
            )
        )
        
        let url1 = URL(string: "https://gips0.baidu.com/it/u=3822353666,2757632348&fm=3028&app=3028&f=JPEG&fmt=auto?w=720&h=1280")

        Nuke.loadImage(with: url1, options: options, into: self.imageViewTwo)
        
        
        
        let url2 = URL(string: "https://gips1.baidu.com/it/u=3874647369,3220417986&fm=3028&app=3028&f=JPEG&fmt=auto?w=720&h=1280")
        
    
        //设定优先级高，内存缓存策略，禁止内存缓存
        var request = ImageRequest(
            url: url2,
            priority:.high,
            options:.disableMemoryCache
        )
        
        Nuke.loadImage(with: request, into: self.imageViewThree)
        
        
        let url3 = URL(string: "https://gips2.baidu.com/it/u=295419831,2920259701&fm=3028&app=3028&f=JPEG&fmt=auto?w=720&h=1280")
        
        let task = ImagePipeline.shared.loadImage(with: url3) { response, completed, total in
            
            print("Progress updated: \(completed)/\(total)")
            
        } completion: { result in
            
                 switch result {
                 case .success(let response):
                     
                     self.imageViewFour.image = response.image
                     print("图片加载成功")
                  
                 case .failure(let error):
                     print("图片加载失败，错误原因: \(error)")
                 }
            
        }
        
        //task.cancel()
//        task.setPriority(.high)
        
        
    
        ImageCache.shared.costLimit = 1024 * 1024 * 100
        ImageCache.shared.countLimit = 100
        ImageCache.shared.ttl = 120  

        let url4 = URL(string: "https://gips2.baidu.com/it/u=295419831,2920259701&fm=3028&app=3028&f=JPEG&fmt=auto?w=720&h=1280")
        
     
        let request1 = ImageRequest(url: url4)
        
        let image = ImageCache.shared[request1]
        ImageCache.shared[request1] = image
        
        ImageCache.shared.removeAll()
        
    }


}

