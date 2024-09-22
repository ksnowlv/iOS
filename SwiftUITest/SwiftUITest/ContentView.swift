//
//  ContentView.swift
//  SwiftUITest
//
//  Created by ksnowlv on 2024/9/7.
//

import SwiftUI

//struct ContentView: View {
//
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//
//        }
//        .padding()
//    }
//}

struct ContentView: View {
    // 定义一个状态变量来控制Alert的显示
    @State private var showAlert = false
    
    // 定义一个状态变量来控制活动指示器的显示
    @State private var isAnimating: Bool = false
    
    var body: some View {
        
        VStack {
            
            Button("Show UIAlert") {
                showAlert = true
            }
            .background(UIAlertViewController(isPresented: $showAlert, title: "UIKit UIAlertViewController", message: "This is a UIAlert from UIKit!"))
            
            // 使用ActivityIndicatorView，并绑定 isAnimating 状态
            ActivityIndicatorView(isAnimating: $isAnimating)
                .frame(width: 50, height: 50) // 设置活动指示器的大小
            
            Button(action: {
                // 切换活动指示器的状态
                isAnimating.toggle()
            }) {
                Text(isAnimating ? "ActivityIndicatorView Stop" : "ActivityIndicatorView Start")
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
