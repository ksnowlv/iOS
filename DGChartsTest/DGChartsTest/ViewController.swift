//
//  ViewController.swift
//  DGChartsTest
//
//  Created by ksnowlv on 2024/8/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleShowBarChartViewController(_ sender: AnyObject) {
        
        let viewController = BarChartViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func handleShowBubbleChartViewController(_ sender: AnyObject) {
        
        let viewController = BubbleChartViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func handleShowCandleStickChartViewController(_ sender: AnyObject) {
        
        let viewController = CandleStickChartViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func handleShowColoredLineChartViewController(_ sender: AnyObject) {
        
        let viewController = ColoredLineChartViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func handleShowCombinedChartViewControllerr(_ sender: AnyObject) {
        
        let viewController = CombinedChartViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func handleShowLineChart1ViewController(_ sender: AnyObject) {
        
        let viewController = LineChart1ViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func handleShowLineChart2ViewController(_ sender: AnyObject) {
        
        let viewController = LineChart2ViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func handleShowLineChartFilledViewController(_ sender: AnyObject) {
        
        let viewController = LineChartFilledViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func handleShowMultipleLinesChartViewController(_ sender: AnyObject) {
        
        let viewController = MultipleLinesChartViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    @IBAction func handleShowPieChartViewController(_ sender: AnyObject) {
        
        let viewController = PieChartViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func handleShowPiePolylineChartViewController(_ sender: AnyObject) {
        
        let viewController = PiePolylineChartViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }


}

