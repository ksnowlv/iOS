//
//  ViewController.swift
//  SwiftyGifTest
//
//  Created by ksnowlv on 2024/8/20.
//

import UIKit
import SwiftyGif

class ViewController: UIViewController {
    @IBOutlet weak var imageView1: UIImageView?
    @IBOutlet weak var imageView2: UIImageView?
    @IBOutlet weak var imageView3: UIImageView?
    @IBOutlet weak var imageView4: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testGif()
    }
    
    func testGif()  {
        
        // load local gif
        do {
            let gif = try UIImage(gifName: "2.gif")
            self.imageView1?.setGifImage(gif)
            
        } catch {
            print(error)
        }
        
        
        // load url gif
       
        let url = URL(string: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage109.360doc.com%2FDownloadImg%2F2018%2F08%2F2516%2F142317964_18_20180825040206786.gif&refer=http%3A%2F%2Fimage109.360doc.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1726969670&t=93d2a38e047799182c2c35942db1b491")!
        
        
//        let loader = UIActivityIndicatorView(style: .white)
//        self.imageView2?.setGifFromURL(url, customLoader: loader)
        self.imageView2?.setGifFromURL(url)
        
        
//        Level of integrity
//
//        Setting a lower level of integrity will allow for frame skipping, lowering both CPU and memory usage. This can be a good option if you need to preview a lot of gifs at the same time.

        do {
            let gif = try UIImage(gifName: "2.gif", levelOfIntegrity:0.5)
            self.imageView3?.setGifImage(gif)
            
        } catch {
            print(error)
        }
        
        do {
            let gif = try UIImage(gifName: "2.gif", levelOfIntegrity:1)
            self.imageView4?.setGifImage(gif)
        } catch {
            print(error)
        }
        
    
        self.imageView4?.startAnimatingGif()
        self.imageView4?.stopAnimatingGif()
        self.imageView4?.showFrameForIndexDelta(3)
        self.imageView4?.showFrameAtIndex(1)
       

        print("isAnimatingGif:\(self.imageView4?.isAnimatingGif()), framesCount:\( self.imageView4?.gifImage?.framesCount())")
    }


}

