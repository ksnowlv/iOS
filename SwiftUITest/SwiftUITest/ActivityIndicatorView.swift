//
//  ActivityIndicatorView.swift
//  SwiftUITest
//
//  Created by ksnowlv on 2024/9/21.
//

import Foundation

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    // 定义一个绑定属性来控制活动指示器的状态
    @Binding var isAnimating: Bool
    
    // 创建并返回一个 UIView 实例
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        // 创建活动指示器，并设置其样式
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        // 可以在这里设置其他属性，比如颜色
        activityIndicator.color = .blue
        return activityIndicator
    }
    
    // 更新 UIView
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        // 根据绑定值来启动或停止动画
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

