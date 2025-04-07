//
//  ViewController.swift
//  UserInterfaceStyleTest
//
//  Created by ksnowlv on 2024/9/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var styleSwitchButton: UIButton!
    @IBOutlet var styleTextLabel: UILabel!
    @IBOutlet var styleImageView: UIImageView!
    
    let customDynamicColor = UIColor { traitCollection in
        if traitCollection.userInterfaceStyle == .light {
            return UIColor.red
        } else {
            return UIColor.green
        }
    }
    
    let customDynamicColorWithProvider = UIColor(dynamicProvider: { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return UIColor.red
        default:
            return UIColor.green
        }
    })
    
    
    let dynamicAssetCatalogColor  = UIColor(named: "TextColor")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let color = UIColor.systemRed
        
        let traitCollection = UITraitCollection.current
        
        styleTextLabel.textColor = customDynamicColor
        styleTextLabel.textColor = customDynamicColorWithProvider
        //        styleTextLabel.textColor = dynamicAssetCatalogColor
        
        
        styleImageView.contentMode = .scaleAspectFit
        
        // 加载动态图片
        if let image = UIImage(named: "demoImage") {
//            styleImageView.image = image
        }
        
        
        
        loadDynamicImages()
        
        
        if traitCollection.userInterfaceStyle == .dark {
            styleImageView.image = UIImage(named: "darkImage")
        }
        else {
            styleImageView.image = UIImage(named: "lightImage")
        }

        
        //        styleTextLabel.textColor = dynamicBKColor // 动态文本颜色
        //        styleTextLabel.backgroundColor = UIColor.systemBackground // 动态背景颜色
        //        self.styleSwitchButton.backgroundColor = self.dynamicBKColor
    }
    
    func loadDynamicImages()  {
        let imageAsset = UIImageAsset()
        if let lightImage = UIImage(named: "lightImage") {
            imageAsset.register(lightImage, with: UITraitCollection(userInterfaceStyle: .light))
        }
        if let darkImage = UIImage(named: "darkImage") {
            imageAsset.register(darkImage, with: UITraitCollection(userInterfaceStyle: .dark))
        }
        
        // 需要设置 UIImageView 的图片
        styleImageView.image = imageAsset.image(with: traitCollection)
    }
    
    
    
    @IBAction func handleStyleSwitchEvent(_ sender: AnyObject) {
        self.toggleUserInterfaceStyle()
    }
    
    func toggleUserInterfaceStyle() {
        
        let styleKey = "preferredInterfaceStyle"
        let style = UserDefaults.standard.string(forKey: styleKey)
        
        if style == "dark" {
            //               self.overrideUserInterfaceStyle = .light
            //               self.navigationController?.overrideUserInterfaceStyle = .light
            self.topKeyWindow()?.overrideUserInterfaceStyle = .light
            UserDefaults.standard.set("light", forKey: "preferredInterfaceStyle")
            self.styleTextLabel.text = "当前为浅色主题"
            
        } else if style == "light" {
            //               self.overrideUserInterfaceStyle = .dark
            UserDefaults.standard.set("dark", forKey: "preferredInterfaceStyle")
            self.styleTextLabel.text = "当前为夜间主题"
            //               self.navigationController?.overrideUserInterfaceStyle = .dark
            self.topKeyWindow()?.overrideUserInterfaceStyle = .dark
        } else  {
            
            let  systemStyle = UITraitCollection.current.userInterfaceStyle;
            
            if (systemStyle == .light) {
                UserDefaults.standard.set("light", forKey: "preferredInterfaceStyle")
            } else if systemStyle == .dark {
                UserDefaults.standard.set("dark", forKey: "preferredInterfaceStyle")
            } else  {
                UserDefaults.standard.set("unspecified", forKey: "preferredInterfaceStyle")
            }
            
        }
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func handleShowAViewControllerEvent(_ sender: AnyObject) {
        
        let viewController = AViewController(nibName: "AViewController", bundle: nil)
        viewController.title = "AViewController"
        self.navigationController?.pushViewController(viewController, animated: true);
        
    }
    
    func topKeyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            // 遍历所有场景的窗口
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow && $0.windowLevel == UIWindow.Level.normal }
        } else {
            // 在iOS 12及以下版本，直接获取key window
            return UIApplication.shared.keyWindow
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // 检查界面风格是否发生变化
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            // 更新颜色以匹配新的界面风格
            //               updateColorsForTraitCollection(traitCollection: traitCollection)
        }
    }
    
    func updateColorsForTraitCollection(traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            // 如果是暗色模式，设置深色背景和浅色文本
            styleTextLabel.textColor = UIColor.red
            styleImageView.image = UIImage(named: "darkImage")
        } else {
            // 如果是亮色模式，设置浅色背景和深色文本
            styleTextLabel.textColor = UIColor.green
            styleImageView.image = UIImage(named: "lightImage")
        }
    }
}

