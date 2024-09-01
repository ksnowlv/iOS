//
//  ViewController.swift
//  KingfisherTest
//
//  Created by ksnowlv on 2024/8/11.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var imageViewOne: UIImageView!
    @IBOutlet weak var imageViewTwo: UIImageView!
    @IBOutlet weak var imageViewThree: UIImageView!
    @IBOutlet weak var imageViewFour: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testKF()
    
        
    }
    
    func testKF()   {
        //url
        let url = URL(string: "https://gips3.baidu.com/it/u=1039279337,1441343044&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f1024_1024")
        self.imageViewOne.kf.setImage(with: url)
        
        
        //url1
        let url1 = URL(string: "https://gips0.baidu.com/it/u=3822353666,2757632348&fm=3028&app=3028&f=JPEG&fmt=auto?w=720&h=1280")
        
        let processor = DownsamplingImageProcessor(size: self.imageViewTwo.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 20)
        self.imageViewTwo.kf.indicatorType = .activity
        self.imageViewTwo.kf.setImage(
            with: url1,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        //
        let url2 = URL(string: "https://gips1.baidu.com/it/u=3874647369,3220417986&fm=3028&app=3028&f=JPEG&fmt=auto?w=720&h=1280")!
        
        
        self.imageViewThree.kf.setImage(
            with: url2,
            placeholder: nil,
            options: [
                .processor(processor),
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
        
        let url3 = URL(string: "https://gips2.baidu.com/it/u=295419831,2920259701&fm=3028&app=3028&f=JPEG&fmt=auto?w=720&h=1280")

        // Use `KF` builder
        KF.url(url3)
          .placeholder(nil)
          .setProcessor(processor)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .onProgress { receivedSize, totalSize in
                print("receivedSize:\(receivedSize), totalSize:\(totalSize)")
          }
          .onSuccess { result in
              print("\(result.image)")
          }
          .onFailure { error in
              print("error:\(error)")
          }
          .set(to: self.imageViewFour)
        
    }


}

